//
//  DrugCompositionRowComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 03/10/2020.
//

import SwiftUI

struct DrugCompositionRowComponent: View {
    
    // MARK: - Properties
    var drugComposition: DrugComposition
    
    // MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(drugComposition.substanceName)
                
                if !drugComposition.substanceCode.isEmpty {
                    Text("§Code de la substance : \(drugComposition.substanceCode)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                
                Text(drugComposition.prettyComponentNature)
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            Text(drugComposition.substanceDosage)
                .foregroundColor(.accent)
        }
    }
}

#if DEBUG
struct DrugCompositionRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        DrugCompositionRowComponent(drugComposition: DrugComposition.one)
            .previewLayout(.fixed(width: 375,
                                  height: 100))
    }
}
#endif
