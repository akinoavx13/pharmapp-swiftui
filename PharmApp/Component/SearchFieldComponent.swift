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
    var placeholder: LocalizedStringKey = "§Rechercher"
    
    // MARK: - Body
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                
                TextField(placeholder,
                          text: $searchText)
                    .foregroundColor(.primary)
                
                Button(action: {
                    self.searchText = ""
                }, label: {
                    Image(systemName: "xmark.circle.fill")
                        .opacity(searchText == "" ? 0 : 1)
                })
            }
            .padding(8)
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .mask(RoundedRectangle(cornerRadius: 10))
            
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
