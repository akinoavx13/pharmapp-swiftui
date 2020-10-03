//
//  DrugDetailsHeaderRowComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 03/10/2020.
//

import SwiftUI

struct DrugDetailsHeaderRowComponent: View {
    
    // MARK: - Properties
    var iconSystemName: String
    var accentColor: Color
    var title: String
    var value: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: iconSystemName)
                .foregroundColor(accentColor)

            VStack(alignment: .leading,
                   spacing: 4) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(accentColor)

                Text(value)
                    .font(.callout)
            }
            
            Spacer()
        }
    }
}

#if DEBUG
struct DrugDetailsHeaderRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        DrugDetailsHeaderRowComponent(iconSystemName: "pencil.circle.fill",
                                      accentColor: .green,
                                      title: "Title",
                                      value: "Value")
            .previewLayout(.fixed(width: 375,
                                  height: 100))
    }
}
#endif
