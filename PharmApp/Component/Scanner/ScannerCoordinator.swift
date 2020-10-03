//
//  ScannerCoordinator.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

import AVFoundation
import Foundation

class ScannerCoordinator: NSObject, AVCaptureMetadataOutputObjectsDelegate {
    // MARK: - Properties

    var parent: ScannerComponent
    var isCodeFound = false

    // MARK: - Lifecycle

    init(parent: ScannerComponent) {
        self.parent = parent
    }

    // MARK: - Methods

    func metadataOutput(_: AVCaptureMetadataOutput,
                        didOutput metadataObjects: [AVMetadataObject],
                        from _: AVCaptureConnection) {
        guard
            let metadataObject = metadataObjects.first,
            let readableObject = metadataObject as? AVMetadataMachineReadableCodeObject,
            let stringValue = readableObject.stringValue,
            !isCodeFound
        else { return }

        found(code: stringValue)
    }

    func found(code: String) {
        isCodeFound = true

        parent.completion(.success(code))
    }

    func didFail(reason: ScannerError) {
        parent.completion(.failure(reason))
    }

    func restartScanProcess() {
        isCodeFound = false
    }
}
