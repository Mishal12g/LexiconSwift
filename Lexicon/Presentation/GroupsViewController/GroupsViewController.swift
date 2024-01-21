//
//  ViewController.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

class GroupsViewController: UIViewController {
    private var groups = [Group]()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Список групп пока пустой =)"
        label.textAlignment = .center
        
        return label
    }()
    
    private let errorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "error")
        
        return imageView
    }()
    
    private let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        
        return collection
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(GroupCell.self, forCellWithReuseIdentifier: GroupCell.identity)
        addSubviews()
        setupNavTop()
        addConstraints()
        hideErrorViews()
    }
}

//MARK: - For method
private extension GroupsViewController {
    @objc func addDidTapButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Добавить группу", style: .default, handler: { action in
            self.addGroup()
        }))
        
        alertController.addAction(UIAlertAction(title: "Добавить слово", style: .default, handler: { action in
            self.addWordInGroup()
        }))
        
        alertController.addAction(UIAlertAction(title: "Отмена", style: .cancel, handler: nil))
        
        alertController.popoverPresentationController?.sourceView = sender
        alertController.popoverPresentationController?.sourceRect = sender.bounds
        
        present(alertController, animated: true, completion: nil)
    }
    
    func addWordInGroup() {
        let groupFormVC = WordFormViewController()
        
        let vc = UINavigationController(rootViewController: groupFormVC )
        vc.setupBackground(backgroundColor: .mgBlue, tintColor: .white)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    func addGroup() {
        let groupFormVC = GroupFormViewController()
        groupFormVC.delegate = self
        let vc = UINavigationController(rootViewController: groupFormVC )
        vc.setupBackground(backgroundColor: .mgBlue, tintColor: .white)
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true)
    }
    
    func hideErrorViews() {
        guard !groups.isEmpty else { return }
        errorLabel.isHidden = true
        errorImageView.isHidden = true
    }
    
    func setupNavTop() {
        self.navigationItem.title = "Группы"
        navigationController?.navigationBar.tintColor = .white
        
        guard let image = UIImage(systemName: "plus.circle.fill") else { return }
        let button = UIButton.systemButton(with: image, target: self, action: #selector(addDidTapButton(_:)))
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
        view.addSubview(errorImageView)
        view.addSubview(errorLabel)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            errorImageView.heightAnchor.constraint(equalToConstant: 100),
            errorImageView.widthAnchor.constraint(equalToConstant: 100),
            errorImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            errorImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            errorLabel.topAnchor.constraint(equalTo: errorImageView.bottomAnchor, constant: 10),
            errorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            errorLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }
}

extension GroupsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GroupCell.identity , for: indexPath)
        
        guard let groupCell = cell as? GroupCell else {
            return UICollectionViewCell()
        }
        groupCell.nameGroupLabel.text = groups[indexPath.item].name
        groupCell.backgroundColor = groups[indexPath.item].color
        groupCell.layer.cornerRadius = 16
        
        return groupCell
    }
}

extension GroupsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth: CGFloat = 11 + 11 + 7
        let width = (collectionView.frame.width - paddingWidth) / 2
        
        return CGSize(width: width, height: width * 2 / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 11, left: 11, bottom: 11, right: 11)
    }
}

extension GroupsViewController: GroupFormViewControllerDelegate {
    func createGroup(name: String, color: UIColor) {
        guard !name.isEmpty else { return }
        let newGroup = Group(name: name, color: color, words: [])
        groups.append(newGroup)
        collectionView.performBatchUpdates {
            let indexPath = IndexPath(item: groups.count - 1, section: 0)
            collectionView.insertItems(at: [indexPath])
        }
        
        hideErrorViews()
        self.dismiss(animated: true)
    }
}
