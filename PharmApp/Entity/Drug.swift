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
    let administrativeStatus: String
    let procedureType: String
    let marketingStatus: String
    let marketingAuthorizationDate: String
    let BDMStatus: String
    let europeanAuthorizationNumber: String
    let holders: [String]
    let enhancedMonitoring: String
    
    // MARK: - Lifecycle
    
    init?(row: [String]) {
        if !row.isEmpty {
            cis = row[0]
        } else { return nil }
        
        name = row.count >= 2 ? row[1] : ""
        pharmaceuticalForm = row.count >= 3 ? row[2] : ""
        administrationRoutes = row.count >= 4 ? row[3].components(separatedBy: ";") : []
        administrativeStatus = row.count >= 5 ? row[4] : ""
        procedureType = row.count >= 6 ? row[5] : ""
        marketingStatus = row.count >= 7 ? row[6] : ""
        marketingAuthorizationDate = row.count >= 8 ? row[7] : ""
        BDMStatus = row.count >= 9 ? row[8] : ""
        europeanAuthorizationNumber = row.count >= 10 ? row[9] : ""
        holders = row.count >= 11 ? row[10].components(separatedBy: ";") : []
        enhancedMonitoring = row.count >= 12 ? row[11] : ""
    }
    
    init(cis: String,
         name: String,
         pharmaceuticalForm: String) {
        self.cis = cis
        self.name = name
        self.pharmaceuticalForm = pharmaceuticalForm
        administrationRoutes = []
        administrativeStatus = ""
        procedureType = ""
        marketingStatus = ""
        marketingAuthorizationDate = ""
        BDMStatus = ""
        europeanAuthorizationNumber = ""
        holders = []
        enhancedMonitoring = ""
    }
}

#if DEBUG
extension Drug {
    static let list: [Drug] = [
        Drug(cis: "12345",
             name: "Doliprane",
             pharmaceuticalForm: "Comprimé"),
        Drug(cis: "098765",
             name: "Abilify",
             pharmaceuticalForm: "Comprimé"),
        Drug(cis: "098765",
             name: "Accofil",
             pharmaceuticalForm: "Comprimé")
    ]
}
#endif
