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

    // MARK: - Lifecycle

    init(codeTypes: [AVMetadataObject.ObjectType],
         simulatedData: String = "",
         completion: @escaping (Result<String, ScannerError>) -> Void)
    {
        self.codeTypes = codeTypes
        self.simulatedData = simulatedData
        self.completion = completion
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
                                context _: Context) {}
}

#if DEBUG
    struct ScannerComponent_Previews: PreviewProvider {
        static var previews: some View {
            ScannerComponent(codeTypes: [.qr]) { _ in }
        }
    }
#endif
