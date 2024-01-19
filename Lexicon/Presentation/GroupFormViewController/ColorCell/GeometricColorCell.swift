//
//  GeometricColorCell.swift
//  Lexicon
//
//  Created by mihail on 19.01.2024.
//

import Foundation

struct GeometricColorCell {
    let countCell: Int
    let leftInset: CGFloat
    let rightInset: CGFloat
    let spasingInset: CGFloat
    let paddingWidth: CGFloat
    
    init(countCell: Int, leftInset: CGFloat, rightInset: CGFloat, spasingInset: CGFloat) {
        self.countCell = countCell
        self.leftInset = leftInset
        self.rightInset = rightInset
        self.spasingInset = spasingInset
        self.paddingWidth = leftInset + rightInset + CGFloat(countCell - 1) * spasingInset
    }
}
