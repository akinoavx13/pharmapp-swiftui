//
//  DrugComposition.swift
//  PharmApp
//
//  Created by Maxime Maheo on 03/10/2020.
//

import Foundation

struct DrugComposition: Identifiable {
    // MARK: - Properties

    let id = UUID()
    let cis: String
    let pharmaceuticalName: String
    let substanceCode: String
    let substanceName: String
    let substanceDosage: String
    let dosageReference: String
    let componentNature: String
    let linkNumber: String
    
    var prettyComponentNature: String {
        if componentNature == DrugComposition.format(text: "SA") {
            return "§Principe actif"
        } else if componentNature == DrugComposition.format(text: "ST") {
            return "§Fraction thérapeutique"
        }
        
        return componentNature
    }
    
    // MARK: - Lifecycle

    init?(row: [String]) {
        if !row.isEmpty {
            cis = row[0]
        } else { return nil }
        
        pharmaceuticalName = row.count >= 2 ? DrugComposition.format(text: row[1]) : ""
        substanceCode = row.count >= 3 ? DrugComposition.format(text: row[2]) : ""
        substanceName = row.count >= 4 ? DrugComposition.format(text: row[3]) : ""
        substanceDosage = row.count >= 5 ? DrugComposition.format(text: row[4]) : ""
        dosageReference = row.count >= 6 ? DrugComposition.format(text: row[5]) : ""
        componentNature = row.count >= 7 ? DrugComposition.format(text: row[6]) : ""
        linkNumber = row.count >= 8 ? DrugComposition.format(text: row[7]) : ""
    }

    // MARK: - Methods

    private static func format(text: String) -> String {
        text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .capitalizeFirstLetter()
    }
}

#if DEBUG
extension DrugComposition {
    static let one = DrugComposition(row: ["60234100",
                                           "comprimé",
                                           "02202",
                                           "PARACÉTAMOL",
                                           "1000 mg",
                                           "un comprimé",
                                           "SA",
                                           "1"])!
}
#endif
