//
//  ImportServiceContract.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

protocol ImportServiceContract {
    // MARK: - Properties

    var drugs: [Drug] { get }
    var drugBoxes: [DrugBox] { get }

    // MARK: - Methods

    func loadItems()
}
