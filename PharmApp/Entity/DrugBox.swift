//
//  DrugBox.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

import Foundation

struct DrugBox: Identifiable {
    // MARK: - Properties

    let id = UUID()
    let cis: String
    let cip7: String
    let presentationName: String
    let presentationAdministrationStatus: String
    let AMMStatus: String
    let AMMDate: String
    let cip13: String
    let communitiesApproval: String
    let repaymentRate: [String]
    let price: String
    let repaymentIndications: String

    // MARK: - Lifecycle

    init?(row: [String]) {
        if !row.isEmpty {
            cis = row[0]
        } else { return nil }

        cip7 = row.count >= 2 ? DrugBox.format(text: row[1]) : ""
        presentationName = row.count >= 3 ? DrugBox.format(text: row[2]) : ""
        presentationAdministrationStatus = row.count >= 4 ? DrugBox.format(text: row[3]) : ""
        AMMStatus = row.count >= 5 ? DrugBox.format(text: row[4]) : ""
        AMMDate = row.count >= 6 ? DrugBox.format(text: row[5]) : ""
        cip13 = row.count >= 7 ? DrugBox.format(text: row[6]) : ""
        communitiesApproval = row.count >= 8 ? DrugBox.format(text: row[7]) : ""
        repaymentRate = row.count >= 9 ? row[8]
            .components(separatedBy: ";")
            .map { DrugBox.format(text: $0) } :
            []
        price = row.count >= 10 ? DrugBox.format(text: row[9]) : ""
        repaymentIndications = row.count >= 11 ? DrugBox.format(text: row[10]) : ""
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
    extension DrugBox {
        static let one = DrugBox(row: ["61266250",
                                       "3000147",
                                       "1 tube(s) aluminium verni de 50 g",
                                       "Présentation active",
                                       "Déclaration de commercialisation",
                                       "19/01/1965",
                                       "3400930001479",
                                       "non",
                                       "30%",
                                       "1,61",
                                       "2,63",
                                       "1,02"])!
    }
#endif
