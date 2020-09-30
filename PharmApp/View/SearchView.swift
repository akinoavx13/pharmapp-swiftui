//
//  SearchView.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import SwiftUI

struct SearchView: View {
    
    // MARK: - Properties
    
    @EnvironmentObject private var drugStore: DrugStore
    
    // MARK: - Body

    var body: some View {
        NavigationView {
            List(drugStore.drugs) { drug in
                VStack(alignment: .leading,
                       spacing: 4) {
                    Text(drug.name)
                        .font(.headline)
                    
                    Text(drug.pharmaceuticalForm)
                        .font(.callout)
                        .italic()
                    
                    Text(drug.cis)
                        .font(.caption)
                        .foregroundColor(Color.accent)
                        .padding(.top, 4)
                }
                
            }
            .navigationBarTitle(Text("Médicaments"))
        }
    }
}

#if DEBUG
struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
            .environmentObject(DrugStore.previewStore)
    }
}
#endif
