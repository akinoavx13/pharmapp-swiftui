//
//  DrugStore.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import Combine
import Foundation

enum DrugStoreAction {}

final class DrugStore: ObservableObject {
    // MARK: - Properties

    @Published var drugs: [Drug]
    @Published var searchedDrugs: [Drug]
    @Published var searchText: String = ""

    private var searchCancellable: AnyCancellable?

    // MARK: - Lifecycle

    init(drugs: [Drug] = ImportService.shared.drugs) {
        self.drugs = drugs
        searchedDrugs = drugs

        searchCancellable = $searchText
            .subscribe(on: DispatchQueue.global())
            .debounce(for: .milliseconds(500),
                      scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink(receiveValue: { [weak self] query in
                guard let self = self else { return }

                if query.isEmpty {
                    self.searchedDrugs = self.drugs
                } else {
                    self.searchedDrugs = self.drugs
                        .filter {
                            $0.name
                                .lowercased()
                                .contains(query.lowercased())
                        }
                }
            })
    }

    // MARK: - Methods

    func dispatch(action _: DrugStoreAction) {}
}

#if DEBUG
    extension DrugStore {
        static let previewStore = DrugStore(drugs: Drug.list)
    }
#endif
