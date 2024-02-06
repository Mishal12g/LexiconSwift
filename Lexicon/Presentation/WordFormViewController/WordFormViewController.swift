//
//  WordFormViewController.swift
//  Lexicon
//
//  Created by mihail on 21.01.2024.
//

import UIKit

final class WordFormViewController: UIViewController {
    let viewForm: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let frontTextField: TextField = {
        let textField = TextField()
        
        return textField
    }()
    
    let backTextField: TextField = {
        let textField = TextField()
        
        return textField
    }()
    
    let frontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavTop()
        addSubviews()
        addConstraints()
    }
}

//MARK: - For methods
extension WordFormViewController {
    func addSubviews() {
        [viewForm,
         frontTextField,
         backTextField,
         frontLabel,
         backLabel].forEach {
            view.addSubview($0)
        }
        
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            frontTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            frontTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            frontTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            frontTextField.heightAnchor.constraint(equalToConstant: 50),
            
        ])
    }
    
    func setupNavTop() {
        let button = UIButton.systemButton(with: UIImage(systemName: "chevron.left")!, target: self, action: #selector(actionBack))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.title = "Добавить слово"
    }
    
    @objc func actionBack() {
        self.navigationController?.dismiss(animated: true)
    }
}
