//
//  ScannerComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

import AVFoundation
import SwiftUI

struct ScannerComponent: UIViewControllerRepresentable {
    // MARK: - Properties

    let codeTypes: [AVMetadataObject.ObjectType]
    var simulatedData = ""
    var completion: (Result<String, ScannerError>) -> Void

    var shouldRestartScanProcess: Bool

    // MARK: - Lifecycle

    init(codeTypes: [AVMetadataObject.ObjectType],
         shouldRestartScanProcess: Bool,
         simulatedData: String = "",
         completion: @escaping (Result<String, ScannerError>) -> Void)
    {
        self.codeTypes = codeTypes
        self.simulatedData = simulatedData
        self.completion = completion
        self.shouldRestartScanProcess = shouldRestartScanProcess
    }

    // MARK: - Methods

    func makeCoordinator() -> ScannerCoordinator {
        ScannerCoordinator(parent: self)
    }

    func makeUIViewController(context: Context) -> ScannerViewController {
        let viewController = ScannerViewController()
        viewController.delegate = context.coordinator

        return viewController
    }

    func updateUIViewController(_: ScannerViewController,
                                context: Context)
    {
        if shouldRestartScanProcess {
            context.coordinator.restartScanProcess()
        }
    }
}

#if DEBUG
    struct ScannerComponent_Previews: PreviewProvider {
        static var previews: some View {
            ScannerComponent(codeTypes: [.qr],
                             shouldRestartScanProcess: false) { _ in }
        }
    }
#endif
