//
//  GroupFormViewController.swift
//  Lexicon
//
//  Created by mihail on 19.01.2024.
//

import UIKit

class GroupFormViewController: UIViewController {
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
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            nameGroupTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 55),
            nameGroupTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            nameGroupTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            nameGroupTextField.heightAnchor.constraint(equalToConstant: 49),
            
            nameLabel.bottomAnchor.constraint(equalTo: nameGroupTextField.topAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            
            doneButton.topAnchor.constraint(equalTo: nameGroupTextField.bottomAnchor, constant: 10),
            doneButton.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: nameGroupTextField.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
