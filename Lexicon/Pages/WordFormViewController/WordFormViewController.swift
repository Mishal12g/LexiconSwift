//
//  WordFormViewController.swift
//  Lexicon
//
//  Created by mihail on 21.01.2024.
//

import UIKit

final class WordFormViewController: UIViewController {
    private let groupStore = GroupsStore.shared
    
    private var group: Group?
    private var frontWord: String?
    private var backWord: String?
    
    private let viewForm: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var frontTextField: TextField = {
        let textField = TextField(placeholder: "Передняя карточка")
        textField.addTarget(self, action: #selector(forntTextfieldDidEnter), for: .primaryActionTriggered)
        textField.addTarget(self, action: #selector(frontTextFieldValueChanged), for: .editingChanged)
        
        return textField
    }()
    
    private lazy var backTextField: TextField = {
        let textField = TextField(placeholder: "Задняя карточка")
        textField.addTarget(self, action: #selector(forntTextfieldDidEnter), for: .editingDidEndOnExit)
        textField.addTarget(self, action: #selector(backTextFieldValueChanged), for: .editingChanged)
        
        return textField
    }()
    
    private let frontLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let backLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var groupsButton: Button = {
       let button = Button()
        button.setTitle("Выбрать группу", for: .normal)
        button.addTarget(self, action: #selector(selectGroupDidTap), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var doneButton: Button = {
       let button = Button()
        button.setTitle("Готово", for: .normal)
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupNavTop()
        addSubviews()
        addConstraints()
    }
}

private extension WordFormViewController {
    @objc func selectGroupDidTap() {
        let vc = GroupsListViewController()
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc func didTapDoneButton() {
        guard
            let group = group,
            let backWord = backWord,
            let frontWord = frontWord
        else {
            return
        }
        
        let newCard = Card(front: frontWord, back: backWord)
        
        groupStore.addWordInGroup(group: group, card: newCard)
        print(groupStore.groups)
        dismiss(animated: true)
    }
    
    @objc func frontTextFieldValueChanged() {
        frontWord = frontTextField.text
    }
    
    @objc func backTextFieldValueChanged() {
        backWord = backTextField.text
    }
}

extension WordFormViewController: GroupsListViewControllerDelegate {
    func selectedGroup(group: Group) {
        self.group = group
    }
}

//MARK: - For methods
extension WordFormViewController {
    func addSubviews() {
        [viewForm,
         frontTextField,
         backTextField,
         frontLabel,
         groupsButton,
         doneButton,
         backLabel].forEach {
            view.addSubview($0)
        }
        
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate([
            frontTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 25),
            frontTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            frontTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            frontTextField.heightAnchor.constraint(equalToConstant: 50),
            
            backTextField.topAnchor.constraint(equalTo: frontTextField.bottomAnchor, constant: 15),
            backTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            backTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            backTextField.heightAnchor.constraint(equalToConstant: 50),
            
            groupsButton.topAnchor.constraint(equalTo: backTextField.bottomAnchor, constant: 15),
            groupsButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            groupsButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            groupsButton.heightAnchor.constraint(equalToConstant: 60),
            
            doneButton.topAnchor.constraint(equalTo: groupsButton.bottomAnchor, constant: 15),
            doneButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            doneButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
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
    
    @objc func forntTextfieldDidEnter() {
        backTextField.becomeFirstResponder()
    }
}
