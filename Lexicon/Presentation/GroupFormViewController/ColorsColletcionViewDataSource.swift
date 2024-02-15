//
//  ColorsColletcionViewDataSource.swift
//  Lexicon
//
//  Created by mihail on 15.02.2024.
//

import UIKit

protocol ColorsColletcionViewDelegate: AnyObject {
    func selectedColor(color: UIColor)
}
fileprivate let colors: [UIColor] = [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8, ._9, ._10, ._11, ._12, ._13, ._14, ._15, ._16, ._17, ._18]

fileprivate let params = GeometricColorCell(countCell: 6, leftInset: 19.0, rightInset: 19.0, spasingInset: 5.0)

final class ColorsColletcionViewDataSource: NSObject, UICollectionViewDataSource {
    weak var delegate: ColorsColletcionViewDelegate?

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ColorCell.identity, for: indexPath)
        
        guard let colorCell = cell as? ColorCell else {
            return UICollectionViewCell()
        }
        colorCell.layer.cornerRadius = 16
        colorCell.backgroundColor = colors[indexPath.item]
        
        return colorCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else { return }
        delegate?.selectedColor(color: colors[indexPath.row])
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else { return }
        cell.layer.borderWidth = 0
    }
}

extension ColorsColletcionViewDataSource: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (collectionView.frame.width - params.paddingWidth) / CGFloat(params.countCell)
        let cellHeight = cellWidth
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: params.leftInset, bottom: 0, right: params.rightInset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return params.spasingInset
    }
}
