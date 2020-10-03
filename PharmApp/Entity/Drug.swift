//
//  Drug.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import Foundation

struct Drug: Identifiable {
    // MARK: - Properties

    let id = UUID()
    let cis: String
    let name: String
    let pharmaceuticalForm: String
    let administrationRoutes: [String]
    let AMMStatus: String
    let AMMProcedureType: String
    let marketingStatus: String
    let AMMDate: String
    let BDMStatus: String
    let europeanAuthorizationNumber: String
    let holders: [String]
    let enhancedMonitoring: String

    var prettyName: String {
        (name.components(separatedBy: ",").first ?? name)
    }

    var isMarketingStatusPositive: Bool {
        !marketingStatus
            .lowercased()
            .contains("non")
    }

    var isAMMStatusPositive: Bool {
        AMMStatus
            .lowercased()
            .contains("active")
    }

    var isBDMStatusPositive: Bool {
        !(BDMStatus.lowercased().contains("alerte") ||
            BDMStatus.lowercased().contains("warning"))
    }

    var isEnhancedMonitoring: Bool {
        enhancedMonitoring.lowercased() == "oui"
    }

    // MARK: - Lifecycle

    init?(row: [String]) {
        if !row.isEmpty {
            cis = row[0]
        } else { return nil }

        name = row.count >= 2 ? Drug.format(text: row[1]) : ""
        pharmaceuticalForm = row.count >= 3 ? Drug.format(text: row[2]) : ""
        administrationRoutes = row.count >= 4 ?
            row[3]
            .components(separatedBy: ";")
            .map { Drug.format(text: $0) } :
            []
        AMMStatus = row.count >= 5 ? Drug.format(text: row[4]) : ""
        AMMProcedureType = row.count >= 6 ? Drug.format(text: row[5]) : ""
        marketingStatus = row.count >= 7 ? Drug.format(text: row[6]) : ""
        AMMDate = row.count >= 8 ? Drug.format(text: row[7]) : ""
        BDMStatus = row.count >= 9 ? Drug.format(text: row[8]) : ""
        europeanAuthorizationNumber = row.count >= 10 ? Drug.format(text: row[9]) : ""
        holders = row.count >= 11 ?
            row[10]
            .components(separatedBy: ";")
            .map { Drug.format(text: $0) } :
            []
        enhancedMonitoring = row.count >= 12 ? Drug.format(text: row[11]) : ""
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
    extension Drug {
        static let one = Drug(row: ["60234100",
                                    "DOLIPRANE 1000 mg, comprimÈ",
                                    "comprimé",
                                    "orale",
                                    "Autorisation active",
                                    "Procédure nationale",
                                    "Commercialisée",
                                    "09/07/2002",
                                    "SANOFI AVENTIS FRANCE",
                                    "Non",
                                    "SANOFI AVENTIS FRANCE;EG LABO - LABORATOIRES EUROGENERICS"])!

        static let list: [Drug] = [
            Drug(row: ["61266250",
                       "A 313 200 000 UI POUR CENT, pommade",
                       "pommade",
                       "cutanée",
                       "Autorisation active",
                       "Procédure nationale",
                       "Commercialisée",
                       "12/03/1998",
                       "PHARMA DEVELOPPEMENT",
                       "Non",
                       "SANOFI AVENTIS FRANCE;EG LABO - LABORATOIRES EUROGENERICS"])!,
            Drug(row: ["62869109",
                       "A 313 50 000 U.I., capsule molle",
                       "capsule molle",
                       "orale",
                       "Autorisation active",
                       "Procédure nationale",
                       "Commercialisée",
                       "07/07/1997",
                       "PHARMA DEVELOPPEMENT",
                       "Non",
                       "SANOFI AVENTIS FRANCE;EG LABO - LABORATOIRES EUROGENERICS"])!,
            Drug(row: ["62401060",
                       "ABACAVIR MYLAN 300 mg, comprimé pelliculé sécable",
                       "comprimé pelliculé sécable",
                       "orale",
                       "Autorisation active",
                       "ProcÈdure nationale",
                       "CommercialisÈe",
                       "21/02/2018",
                       "MYLAN SAS",
                       "Non",
                       "SANOFI AVENTIS FRANCE"])!
        ]
    }
#endif
