//
//  DrugDetailsReferenceRowComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 03/10/2020.
//

import SwiftUI

struct DrugDetailsReferenceRowComponent: View {
    
    // MARK: - Properties
    var title: String
    var value: String
    
    // MARK: - Body
    var body: some View {
        HStack {
            Text(title)

            Spacer()

            Text(value)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}

#if DEBUG
struct DrugDetailsReferenceRowComponent_Previews: PreviewProvider {
    static var previews: some View {
        DrugDetailsReferenceRowComponent(title: "title",
                                         value: "value")
            .previewLayout(.fixed(width: 375,
                                  height: 100))
    }
}
#endif
