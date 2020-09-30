//
//  String+CapitalizingFirstLetter.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

extension String {
    func capitalizeFirstLetter() -> String {
        prefix(1).capitalized + dropFirst()
    }
}
