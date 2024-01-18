//
//  ViewController.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

class GroupsViewController: UIViewController {
    private var groups = [String]()
    private var countGroups = 0
    
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
    }
    
    @objc func addDidTapButton() {
        addGroup()
    }
}

//MARK: - For method
private extension GroupsViewController {
    func addGroup() {
        let emotions = ["🍇", "🍈", "🍉", "🍊", "🍋", "🍌", "🍍", "🥭", "🍎", "🍏", "🍐", "🍒", "🍓", "🫐", "🥝", "🍅", "🫒", "🥥", "🥑", "🍆", "🥔", "🥕", "🌽", "🌶️", "🫑", "🥒", "🥬", "🥦", "🧄", "🧅", "🍄"]
        
        if countGroups != emotions.count {
            groups.append(emotions[countGroups])
            collectionView.performBatchUpdates {
                let indexPath = IndexPath(item: groups.count - 1, section: 0)
                collectionView.insertItems(at: [indexPath])
            }
        }
        
        if countGroups != groups.count {
            countGroups += 1
        }
    }
    
    func setupNavTop() {
        self.navigationItem.title = "Группы"
        navigationController?.navigationBar.tintColor = .white
        
        guard let image = UIImage(systemName: "plus.circle.fill") else { return }
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: UIButton.systemButton(with: image, target: self, action: #selector(addDidTapButton)))
    }
    
    func addSubviews() {
        view.addSubview(collectionView)
    }
    
    func addConstraints(){
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
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
        groupCell.nameGroupLabel.text = groups[indexPath.item]
        
        
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
