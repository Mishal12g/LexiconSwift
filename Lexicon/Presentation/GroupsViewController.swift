//
//  ViewController.swift
//  Lexicon
//
//  Created by mihail on 18.01.2024.
//

import UIKit

class GroupsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavTop()
        view.backgroundColor = .white
    }
}

//MARK: - For method
private extension GroupsViewController {
    func setupNavTop() {
        navigationItem.title = "Группы"
        navigationItem.titleView?.tintColor = .white
        navigationController?.navigationBar.backgroundColor = .mgBlue
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
