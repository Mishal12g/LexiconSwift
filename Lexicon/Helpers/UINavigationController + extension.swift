//
//  UINavigationController + extends.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

extension UINavigationController {
    func setupBackground(backgroundColor: UIColor, tintColor: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = backgroundColor
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationBar.tintColor = tintColor
        navigationBar.standardAppearance = appearence
        navigationBar.scrollEdgeAppearance = appearence
    }
}
