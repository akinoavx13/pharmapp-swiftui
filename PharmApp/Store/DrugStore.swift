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
    case scannerDidFound(code: String)
    case drugDetailsDidOpen(drug: Drug)
    case drugDetailsDidClose
}

final class DrugStore: ObservableObject {
    // MARK: - Properties

    @Published var drugs: [Drug]
    @Published var scannedDrug: Drug?
    @Published var currentDrugBoxes: [DrugBox] = []
    @Published var currentDrugCompositions: [DrugComposition] = []
    @Published var shouldRestartScanProcess: Bool = false
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
        case let .scannerDidFound(code):
            findDrug(with: code)
        case let .drugDetailsDidOpen(drug):
            currentDrugBoxes = findDrugBoxes(cis: drug.cis)
            currentDrugCompositions = findDrugCompositions(cis: drug.cis)
        case .drugDetailsDidClose:
            scannedDrug = nil
            currentDrugBoxes.removeAll()
            currentDrugCompositions.removeAll()
            shouldRestartScanProcess = true
        }
    }

    private func findDrug(with code: String) {
        let cip13 = extractCIP13(from: code)
        let drug = findDrug(cip13: cip13)

        if let drug = drug {
            shouldRestartScanProcess = false

            UIImpactFeedbackGenerator(style: .heavy)
                .impactOccurred()
            scannedDrug = drug
        }
    }

    private func findDrug(cip13: String) -> Drug? {
        let drugBox = ImportService
            .shared
            .drugBoxes
            .first(where: { $0.cip13 == cip13 })

        let drug = drugs
            .first(where: { $0.cis == drugBox?.cis })

        return drug
    }

    private func findDrugBoxes(cis: String) -> [DrugBox] {
        ImportService
            .shared
            .drugBoxes
            .filter { $0.cis == cis }
    }
    
    private func findDrugCompositions(cis: String) -> [DrugComposition] {
        ImportService
            .shared
            .drugCompositions
            .filter { $0.cis == cis }
    }

    private func extractCIP13(from code: String) -> String {
        if code.count >= 17 {
            let startIndex = code.index(code.startIndex, offsetBy: 4)
            let endIndex = code.index(code.startIndex, offsetBy: 17)
            let cip13 = code[startIndex ..< endIndex]

            return String(cip13)
        }

        return code
    }
}

#if DEBUG
    extension DrugStore {
        static let previewStore = DrugStore(drugs: Drug.list)
    }
#endif
