//
//  DrugStore.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import Combine

enum DrugStoreAction {}

final class DrugStore: ObservableObject {
    
    // MARK: - Properties
    @Published var drugs: [Drug]
    
    // MARK: - Lifecycle

    init(drugs: [Drug] = ImportService.shared.drugs) {
        self.drugs = drugs
    }

    // MARK: - Methods

    func dispatch(action: DrugStoreAction) {}
}

#if DEBUG
extension DrugStore {
    static let previewStore = DrugStore(drugs: Drug.list)
}
#endif
