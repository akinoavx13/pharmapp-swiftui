//
//  DrugBox.swift
//  PharmApp
//
//  Created by Maxime Maheo on 02/10/2020.
//

struct DrugBox {
    // MARK: - Properties

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
        presentationAdministrationStatus = row.count >= 4 ? DrugBox.format(text: row[5]) : ""
        AMMStatus = row.count >= 5 ? DrugBox.format(text: row[4]) : ""
        AMMDate = row.count >= 6 ? DrugBox.format(text: row[5]) : ""
        cip13 = row.count >= 7 ? DrugBox.format(text: row[6]) : ""
        communitiesApproval = row.count >= 8 ? DrugBox.format(text: row[7]) : ""
        repaymentRate = row.count >= 9 ? row[10]
            .components(separatedBy: ";")
            .map { DrugBox.format(text: $0) } :
            []
        price = row.count >= 10 ? DrugBox.format(text: row[9]) : ""
        repaymentIndications = row.count >= 11 ? DrugBox.format(text: row[12]) : ""
    }

    // MARK: - Methods

    private static func format(text: String) -> String {
        text
            .trimmingCharacters(in: .whitespacesAndNewlines)
            .lowercased()
            .capitalizeFirstLetter()
    }
}
