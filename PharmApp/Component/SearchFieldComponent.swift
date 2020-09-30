//
//  SearchFieldComponent.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import SwiftUI

struct SearchFieldComponent: View {
    // MARK: - Properties

    @Binding var searchText: String
    var placeholder: LocalizedStringKey = "§Rechercher un médicament"

    // MARK: - Body

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)

                TextField(placeholder, text: $searchText)
            }
            .padding(8)
            .background(Color.secondary.opacity(0.2))
            .mask(RoundedRectangle(cornerRadius: 8, style: .continuous))

            if !searchText.isEmpty {
                Button(action: {
                    self.searchText = ""
                }, label: {
                    Text("§Annuler")
                })
            }
        }
    }
}

#if DEBUG
struct SearchFieldComponent_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchFieldComponent(searchText: .constant("Doliprane"))

            SearchFieldComponent(searchText: .constant(""))

            SearchFieldComponent(searchText: .constant("Doliprane"))
                .preferredColorScheme(.dark)
        }
        .previewLayout(.fixed(width: 375, height: 55))
    }
}
#endif
