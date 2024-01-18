//
//  GroupCell.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

final class GroupCell: UICollectionViewCell {
    static let identity = "GroupCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .mgOrange
        contentView.layer.cornerRadius = 16
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
