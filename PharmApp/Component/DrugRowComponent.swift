//
//  DrugRowComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import SwiftUI

struct DrugRowComponent: View {
    
    // MARK: - Properties
    var drug: Drug
    
    // MARK: - Body
    var body: some View {
        HStack {
            VStack(alignment: .leading,
                   spacing: 4) {
                Text(drug.prettyName)
                    .font(.headline)
                
                Text(drug.prettyPharmaceuticalForm)
                    .font(.callout)
                    .italic()
                
                Text(drug.cis)
                    .font(.caption)
                    .foregroundColor(Color.accent)
                    .padding(.top, 4)
            }
            
            Spacer()
        }
    }
}

#if DEBUG
struct DrugRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DrugRowComponent(drug: Drug.one)
                .preferredColorScheme(.light)
            
            DrugRowComponent(drug: Drug.one)
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 375,
                              height: 100))
        
    }
}
#endif
