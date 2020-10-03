//
//  DrugDetailsStatusRowComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 03/10/2020.
//

import SwiftUI

struct DrugDetailsStatusRowComponent: View {
    
    // MARK: - Properties
    var title: String
    var value: String
    var isPositive: Bool
    var subtitle: String?
    
    // MARK: - Body
    var body: some View {
        HStack {
            Image(systemName: isPositive ?
                "checkmark.circle.fill" :
                "exclamationmark.triangle.fill")
                .foregroundColor(isPositive ?
                    .green :
                    .red)

            VStack(alignment: .leading,
                   spacing: 4) {
                Text(title)

                Text(value)
                    .font(.callout)
                    .foregroundColor(isPositive ?
                        .green :
                        .red)

                subtitle.map {
                    Text($0)
                        .font(.caption)
                        .italic()
                        .foregroundColor(.gray)
                }
            }
            
            Spacer()
        }
    }
}

#if DEBUG
struct DrugDetailsStatusRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            DrugDetailsStatusRowComponent(title: "title",
                                          value: "value",
                                          isPositive: true,
                                          subtitle: "subtitle")
            
            DrugDetailsStatusRowComponent(title: "title",
                                          value: "value",
                                          isPositive: true)
        }
        .previewLayout(.fixed(width: 375,
                              height: 100))
    }
}
#endif
