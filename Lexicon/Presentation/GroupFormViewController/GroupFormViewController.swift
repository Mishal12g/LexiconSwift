//
//  GroupFormViewController.swift
//  Lexicon
//
//  Created by mihail on 19.01.2024.
//

import UIKit

class GroupFormViewController: UIViewController {
    private let colors: [UIColor] = [._1, ._2, ._3, ._4, ._5, ._6, ._7, ._8, ._9, ._10, ._11, ._12, ._13, ._14, ._15, ._16, ._17, ._18]
    
    private let params = GeometricColorCell(countCell: 6, leftInset: 19.0, rightInset: 19.0, spasingInset: 5.0)
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    private let doneButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.backgroundColor = .mgBlue
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 25)
        button.setTitle("Готово", for: .normal)
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Имя группы"
        
        return label
    }()
    
    private let nameGroupTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .systemGray4
        textField.font = UIFont.systemFont(ofSize: 24)
        textField.layer.cornerRadius = 16
        textField.addPadding(.both(10))
        textField.becomeFirstResponder()
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identity)
        collectionView.allowsMultipleSelection = false
        setupNavTop()
        addSubviews()
        addConstraints()
    }
}

//MARK: - For methods
private extension GroupFormViewController {
    func setupNavTop() {
        let button = UIButton.systemButton(with: UIImage(systemName: "chevron.left")!, target: self, action: #selector(action))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.title = "Создать Группу"
    }
    
    @objc func action() {
        self.navigationController?.dismiss(animated: true)
    }
    
    func addSubviews() {
        view.addSubview(nameGroupTextField)
        view.addSubview(nameLabel)
        view.addSubview(doneButton)
        view.addSubview(collectionView)
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameGroupTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            nameGroupTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameGroupTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameGroupTextField.heightAnchor.constraint(equalToConstant: 49),
            
            nameLabel.bottomAnchor.constraint(equalTo: nameGroupTextField.topAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            
            doneButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: nameGroupTextField.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
            
            collectionView.topAnchor.constraint(equalTo: nameGroupTextField.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
}

//MARK: - CollectionViewDataSource
extension GroupFormViewController: UICollectionViewDataSource {
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
        cell.layer.borderColor = UIColor.white.cgColor
        cell.layer.borderWidth = 3
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? ColorCell else { return }
        cell.layer.borderWidth = 0
    }
}

//MARK: - CollectionViewDelegate
extension GroupFormViewController: UICollectionViewDelegateFlowLayout {
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
