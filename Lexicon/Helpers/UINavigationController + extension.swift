//
//  UINavigationController + extends.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

extension UINavigationController {
    func setupBackground(color: UIColor) {
        let appearence = UINavigationBarAppearance()
        appearence.configureWithOpaqueBackground()
        appearence.backgroundColor = color
        appearence.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationBar.standardAppearance = appearence
        navigationBar.scrollEdgeAppearance = appearence
    }
}
