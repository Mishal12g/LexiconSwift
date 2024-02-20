//
//  TextField.swift
//  Lexicon
//
//  Created by mihail on 21.01.2024.
//

import UIKit

final class TextField: UITextField {
    
    init(placeholder: String? = nil) {
        super.init(frame: .zero)

        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .systemGray4
        self.font = UIFont.systemFont(ofSize: 24)
        self.layer.cornerRadius = 16
        self.addPadding(.both(10))
        self.placeholder = placeholder
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
