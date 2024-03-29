//
//  GroupCell.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

final class GroupCell: UICollectionViewCell {
    static let identity = "GroupCell"
    
    private var completedCount: Int = 0
    private var countCards: Int = 0
    
    let nameGroupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .white
        label.numberOfLines = 1
        
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.systemFont(ofSize: 12, weight: .light)
        label.textColor = .white
        label.text = "\(completedCount)/\(countCards)"
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 16
        contentView.addSubview(nameGroupLabel)
        contentView.addSubview(countLabel)
        addContstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCell(group: Group) {
        nameGroupLabel.text = group.name
        countCards = group.cards.count
        countLabel.text = "\(completedCount)/\(countCards)"
        backgroundColor = group.color
        layer.cornerRadius = 16
    }
}

private extension GroupCell {
    func addContstraints() {
        NSLayoutConstraint.activate([
            nameGroupLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameGroupLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nameGroupLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameGroupLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            
            countLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            countLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
        ])
    }
}
