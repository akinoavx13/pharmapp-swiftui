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
        self.searchedDrugs = drugs
        
        searchCancellable = $searchText
            .subscribe(on: DispatchQueue.global())
            .debounce(for: .milliseconds(500),
                      scheduler: DispatchQueue.main)
            .removeDuplicates()
            .filter { !$0.isEmpty }
            .sink(receiveValue: { [weak self] (query) in
                guard let self = self else { return }
                
                self.searchedDrugs = self.drugs
                    .filter {
                        $0.name
                            .lowercased()
                            .contains(query.lowercased())
                    }
            })
    }
    
    // MARK: - Methods
    
    func dispatch(action: DrugStoreAction) {}
}

#if DEBUG
extension DrugStore {
    static let previewStore = DrugStore(drugs: Drug.list)
}
#endif