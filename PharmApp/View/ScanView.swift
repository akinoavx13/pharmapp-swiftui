//
//  ScanView.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

import SwiftUI

struct ScanView: View {
    // MARK: - Body

    var body: some View {
        ZStack {
            ScannerComponent(codeTypes: [.dataMatrix],
                             simulatedData: "01034009359558381723063010AX411",
                             completion: handleScan(result:))

            VStack {
                Spacer()

                Image(systemName: "viewfinder")
                    .resizable()
                    .frame(width: 150,
                           height: 150)

                Spacer()
                Text("§Placez le code barre de la boite du médicament dans le cadre. Pour une meilleure efficacité, placer le code barre droit.")
                    .italic()
                    .font(.caption)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
            .foregroundColor(.accent)
        }
        .edgesIgnoringSafeArea(.top)
    }

    // MARK: - Methods

    private func handleScan(result: Result<String, ScannerError>) {
        switch result {
        case let .success(code):
            print("QR code is: \(code)")
        case let .failure(error):
            print("Error: \(error)")
        }
    }
}

#if DEBUG
    struct ScanView_Previews: PreviewProvider {
        static var previews: some View {
            ScanView()
        }
    }
#endif
