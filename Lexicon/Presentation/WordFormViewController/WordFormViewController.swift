//
//  WordFormViewController.swift
//  Lexicon
//
//  Created by mihail on 21.01.2024.
//

import UIKit

final class WordFormViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavTop()
    }
}

//MARK: - For methods
extension WordFormViewController {
    func setupNavTop() {
        let button = UIButton.systemButton(with: UIImage(systemName: "chevron.left")!, target: self, action: #selector(actionBack))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.title = "Добавить слово"
    }
    
    @objc func actionBack() {
        self.navigationController?.dismiss(animated: true)
    }
}
