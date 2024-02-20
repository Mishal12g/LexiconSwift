//
//  Button.swift
//  Lexicon
//
//  Created by mihail on 15.02.2024.
//

import UIKit

final class Button: UIButton {
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 16
        backgroundColor = .mgBlue
        tintColor = .white
        titleLabel?.font = .systemFont(ofSize: 20)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
