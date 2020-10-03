//
//  ScanView.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

import SwiftUI

struct ScanView: View {
    // MARK: - Properties

    @EnvironmentObject private var drugStore: DrugStore
    @State private var isAlertPresented = false

    // MARK: - Body

    var body: some View {
        ZStack {
            ScannerComponent(codeTypes: [.dataMatrix,
                                         .ean8,
                                         .ean13,
                                         .pdf417,
                                         .code128,
                                         .code39,
                                         .code39Mod43,
                                         .code93,
                                         .interleaved2of5,
                                         .itf14,
                                         .upce],
                             shouldRestartScanProcess: drugStore.shouldRestartScanProcess,
                             simulatedData: "\u{1D}01034009359558381723063010AX411",
                             completion: handleScan(result:))

            VStack {
                Spacer()

                Image(systemName: "viewfinder")
                    .resizable()
                    .frame(width: 150,
                           height: 150)

                Spacer()
                Text("§Placez la cible dans le cadre. Pour une meilleure efficacité, placez la cible droite.")
                    .italic()
                    .font(.caption)
                    .padding()
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .multilineTextAlignment(.center)
                    .lineLimit(5)
                    .minimumScaleFactor(0.5)
                    .padding(.horizontal, 24)
                    .padding(.bottom, 24)
            }
            .foregroundColor(.accent)
        }
        .edgesIgnoringSafeArea([.top, .horizontal])
        .alert(isPresented: $isAlertPresented) {
            Alert(title: Text("§Erreur"),
                  message: Text("§Une erreur est survenue, veuillez réessayer."),
                  dismissButton: .default(Text("§Compris !")))
        }
        .sheet(isPresented: .constant(drugStore.scannedDrug != nil),
               content: {
                   drugStore.scannedDrug.map {
                       DrugDetailsView(drug: $0)
                   }
               })
    }

    // MARK: - Methods

    private func handleScan(result: Result<String, ScannerError>) {
        switch result {
        case let .success(code):
            drugStore.dispatch(action: .scannerDidFound(code: code))
        case .failure:
            isAlertPresented = true
        }
    }
}

#if DEBUG
    struct ScanView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                ScanView()
                    .preferredColorScheme(.light)

                ScanView()
                    .environment(\.sizeCategory,
                                 .accessibilityExtraExtraExtraLarge)
                    .preferredColorScheme(.dark)
            }
            .environmentObject(DrugStore.previewStore)
        }
    }
#endif
