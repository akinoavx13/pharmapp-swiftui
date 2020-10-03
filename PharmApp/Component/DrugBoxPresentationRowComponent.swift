//
//  DrugBoxPresentationRowComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 03/10/2020.
//

import SwiftUI

struct DrugBoxPresentationRowComponent: View {
    // MARK: - Properties

    var drugBox: DrugBox

    // MARK: - Body

    var body: some View {
        VStack(alignment: .leading,
               spacing: 4) {
            Text(drugBox.presentationName)

            Text(drugBox.presentationAdministrationStatus)
                .font(.callout)
                .foregroundColor(.gray)

            VStack(spacing: 4) {
                makeCIPView(title: "CIP7",
                            cip: drugBox.cip7)
                
                makeCIPView(title: "CIP13",
                            cip: drugBox.cip13)
            }
            .padding(.vertical, 8)
            
            makePriceView()
        }
    }
    
    // MARK: - Methods
    @ViewBuilder
    private func makeCIPView(title: String,
                             cip: String) -> some View {
        if !cip.isEmpty {
            HStack {
                Text(title)
                
                Spacer()
                
                Text(cip)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
        }
    }
    
    @ViewBuilder
    private func makePriceView() -> some View {
        if
            let repaymentRate = drugBox.repaymentRate.first,
            !repaymentRate.isEmpty,
            !drugBox.price.isEmpty
        {
            HStack {
                Text("\(drugBox.price) €")
                    .font(.body)
                    .bold()

                Spacer()

                Text("§Rembourser à \(repaymentRate)")
                    .font(.body)
                    .bold()
            }
            .foregroundColor(.accent)
        }
    }
}

#if DEBUG
    struct DrugBoxPresentationRowComponent_Previews: PreviewProvider {
        static var previews: some View {
            DrugBoxPresentationRowComponent(drugBox: DrugBox.one)
                .previewLayout(.fixed(width: 375,
                                      height: 150))
        }
    }
#endif
