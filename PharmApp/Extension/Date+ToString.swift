//
//  Date+ToString.swift
//  PharmApp
//
//  Created by Maxime Maheo on 01/10/2020.
//

import Foundation

extension Date {
    func toString(dateStyle: DateFormatter.Style = .short,
                  timeStyle: DateFormatter.Style = .none) -> String {
        let dateFormatter = DateFormatter()

        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle

        return dateFormatter.string(from: self)
    }
}
