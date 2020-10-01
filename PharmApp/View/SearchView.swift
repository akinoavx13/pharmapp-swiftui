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
            ScrollView {
                SearchFieldComponent(searchText: $drugStore.searchText,
                                     placeholder: "Doliprane, Spasfon ...")
                    .padding(.horizontal)
                    .padding(.bottom)

                LazyVStack(alignment: .leading) {
                    ForEach(drugStore.searchedDrugs) { drug in
                        NavigationLink(
                            destination: DrugDetailsView(drug: drug),
                            label: {
                                DrugRowComponent(drug: drug)
                                    .padding(.horizontal)
                            }
                        )
                        .buttonStyle(PlainButtonStyle())

                        Divider()
                            .background(Color(.secondarySystemBackground))
                            .padding(.leading)
                    }
                }
            }
            .modifier(DismissingKeyboardOnSwipe())
            .navigationBarTitle(Text("§Médicaments"))
        }
    }
}

#if DEBUG
    struct SearchView_Previews: PreviewProvider {
        static var previews: some View {
            Group {
                SearchView()
                    .preferredColorScheme(.light)

                SearchView()
                    .environment(\.sizeCategory,
                                 .accessibilityExtraExtraExtraLarge)
                    .preferredColorScheme(.dark)
            }
            .environmentObject(DrugStore.previewStore)
        }
    }
#endif
