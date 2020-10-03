//
//  ScannerViewController.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

import AVFoundation
import UIKit

#if targetEnvironment(simulator)
    class ScannerViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        // MARK: - Properties

        weak var delegate: ScannerCoordinator?

        // MARK: - Lifecycle

        override func loadView() {
            view = UIView()
            view.isUserInteractionEnabled = true

            let label = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            label.numberOfLines = 0
            label.text = "You're running in the simulator, which means the camera isn't available. Tap anywhere to send back some simulated data."
            label.textAlignment = .center

            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.spacing = 50
            stackView.addArrangedSubview(label)

            view.addSubview(stackView)

            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
                stackView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
                stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
        }

        // MARK: - Methods

        override func touchesBegan(_: Set<UITouch>, with _: UIEvent?) {
            guard let simulatedData = delegate?.parent.simulatedData else {
                print("Simulated Data Not Provided!")
                return
            }

            delegate?.found(code: simulatedData)
        }

        @objc func openGallery(_: UIButton) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
        }

        func imagePickerController(_: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let qrcodeImg = info[.originalImage] as? UIImage {
                let detector = CIDetector(ofType: CIDetectorTypeQRCode, context: nil, options: [CIDetectorAccuracy: CIDetectorAccuracyHigh])!
                let ciImage = CIImage(image: qrcodeImg)!
                var qrCodeLink = ""

                let features = detector.features(in: ciImage)
                for feature in features.compactMap({ $0 as? CIQRCodeFeature }) {
                    qrCodeLink += feature.messageString!
                }

                if qrCodeLink == "" {
                    delegate?.didFail(reason: .badOutput)
                } else {
                    delegate?.found(code: qrCodeLink)
                }
            } else {
                print("Something went wrong")
            }
            dismiss(animated: true, completion: nil)
        }
    }
#else
    class ScannerViewController: UIViewController {
        // MARK: - Properties

        var captureSession: AVCaptureSession!
        var previewLayer: AVCaptureVideoPreviewLayer!
        weak var delegate: ScannerCoordinator?

        override var prefersStatusBarHidden: Bool {
            true
        }

        override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            .all
        }

        // MARK: - Lifecycle

        override func viewDidLoad() {
            super.viewDidLoad()

            NotificationCenter.default.addObserver(self,
                                                   selector: #selector(updateOrientation),
                                                   name: Notification.Name("UIDeviceOrientationDidChangeNotification"),
                                                   object: nil)

            view.backgroundColor = UIColor.black
            captureSession = AVCaptureSession()
            captureSession.sessionPreset = .high

            guard
                let videoCaptureDevice = AVCaptureDevice.default(for: .video)
            else { return }

            let videoInput: AVCaptureDeviceInput

            do {
                videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
            } catch {
                return
            }

            if captureSession.canAddInput(videoInput) {
                captureSession.addInput(videoInput)
            } else {
                delegate?.didFail(reason: .badInput)
                return
            }

            let metadataOutput = AVCaptureMetadataOutput()

            if captureSession.canAddOutput(metadataOutput) {
                captureSession.addOutput(metadataOutput)

                metadataOutput.setMetadataObjectsDelegate(delegate,
                                                          queue: DispatchQueue.main)
                metadataOutput.metadataObjectTypes = delegate?.parent.codeTypes
            } else {
                delegate?.didFail(reason: .badOutput)
                return
            }

            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer.frame = view.layer.bounds
            previewLayer.videoGravity = .resizeAspectFill
            view.layer.addSublayer(previewLayer)
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)

            if captureSession?.isRunning == false {
                captureSession.startRunning()
            }
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)

            updateOrientation()
        }

        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)

            if captureSession?.isRunning == true {
                captureSession.stopRunning()
            }
        }

        override func viewWillLayoutSubviews() {
            previewLayer?.frame = view.layer.bounds
        }

        deinit {
            NotificationCenter
                .default
                .removeObserver(self)
        }

        // MARK: - Methods

        @objc
        func updateOrientation() {
            guard
                let orientation = UIApplication
                .shared
                .windows
                .first?
                .windowScene?
                .interfaceOrientation,
                let connection = captureSession
                .connections
                .last,
                connection.isVideoOrientationSupported
            else { return }

            connection.videoOrientation = AVCaptureVideoOrientation(rawValue: orientation.rawValue) ?? .portrait
        }
    }
#endif
