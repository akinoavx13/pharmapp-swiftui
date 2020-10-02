//
//  DrugStore.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import Combine
import Foundation
import UIKit

enum DrugStoreAction {
    case findDrugAfterScan(code: String)
}

final class DrugStore: ObservableObject {
    // MARK: - Properties

    @Published var drugs: [Drug]
    @Published var scannedDrug: Drug?
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

    func dispatch(action: DrugStoreAction) {
        switch action {
        case let .findDrugAfterScan(code):
            extract(code: code)
        }
    }

    private func extract(code: String) {
        let startIndex = code.index(code.startIndex, offsetBy: 4)
        let endIndex = code.index(code.startIndex, offsetBy: 17)
        let cip13 = code[startIndex ..< endIndex]

        let drugBox = ImportService
            .shared
            .drugBoxes
            .first(where: { $0.cip13 == cip13 })
        let drug = drugs
            .first(where: { $0.cis == drugBox?.cis })

        if let scannedDrug = drug {
            UIImpactFeedbackGenerator(style: .heavy)
                .impactOccurred()
            self.scannedDrug = scannedDrug
        }
    }
}

#if DEBUG
    extension DrugStore {
        static let previewStore = DrugStore(drugs: Drug.list)
    }
#endif
