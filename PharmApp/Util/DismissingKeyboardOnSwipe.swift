//
//  DismissingKeyboardOnSwipe.swift
//  PharmApp
//
//  Created by Maxime Maheo on 30/09/2020.
//

import SwiftUI

struct DismissingKeyboardOnSwipe: ViewModifier {
    // MARK: - Properties

    private var swipeGesture: some Gesture {
        DragGesture(minimumDistance: 10,
                    coordinateSpace: .global)
            .onChanged(endEditing)
    }

    // MARK: - Methods

    func body(content: Content) -> some View {
        content.gesture(swipeGesture)
    }

    private func endEditing(_: DragGesture.Value) {
        UIApplication
            .shared
            .endEditing(true)
    }
}
