//
//  UIApplication+EndEditing.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import SwiftUI

extension UIApplication {
    func endEditing(_ force: Bool) {
        UIApplication
            .shared
            .connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .map { $0 as? UIWindowScene }
            .compactMap { $0 }
            .first?
            .windows
            .first(where: { $0.isKeyWindow })?
            .endEditing(force)
    }
}
