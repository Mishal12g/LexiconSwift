//
//  GroupFormViewController.swift
//  Lexicon
//
//  Created by mihail on 19.01.2024.
//

import UIKit

protocol GroupFormViewControllerDelegate {
    func createGroup(name: String, color: UIColor)
}

class GroupFormViewController: UIViewController {
    var delegate: GroupFormViewControllerDelegate?
    
    private let dataSource = ColorsColletcionViewDataSource()
    private var color: UIColor?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        
        return scrollView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        dataSource.delegate = self
        collection.dataSource = dataSource
        collection.delegate = dataSource
        collection.register(ColorCell.self, forCellWithReuseIdentifier: ColorCell.identity)
        collection.allowsMultipleSelection = false
        
        return collection
    }()
    
    private lazy var doneButton: Button = {
        let button = Button()
        button.setTitle("Готово", for: .normal)
        button.addTarget(self, action: #selector(didTapDoneButton), for: .touchUpInside)
        
        return button
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Имя группы"
        
        return label
    }()
    
    private let colorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Цвет"
        
        return label
    }()
    
    private lazy var nameGroupTextField: TextField = {
        let textField = TextField()
        textField.becomeFirstResponder()
        textField.delegate = self
        textField.addTarget(self, action: #selector(valueChangeTextField), for: .editingChanged)
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        isEnabledButton()
        setupNavTop()
        addConstraints()
    }
}

//MARK: - For methods
private extension GroupFormViewController {
    func setupNavTop() {
        let button = UIButton.systemButton(with: UIImage(systemName: "chevron.left")!, target: self, action: #selector(actionBack))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.title = "Создать Группу"
    }
    
    func isEnabledButton() {
        guard let text = nameGroupTextField.text else { return }
        doneButton.isEnabled = color != nil && !text.isEmpty
    }
    
    @objc func valueChangeTextField() {
        isEnabledButton()
    }
    
    @objc func didTapDoneButton() {
        guard let color = color else { return }
        delegate?.createGroup(name: nameGroupTextField.text ?? "not", color: color)
    }
    
    @objc func hideKeyboard() {
        nameGroupTextField.resignFirstResponder()
    }
    
    @objc func actionBack() {
        self.navigationController?.dismiss(animated: true)
    }
}

extension GroupFormViewController: ColorsColletcionViewDelegate {
    func selectedColor(color: UIColor) {
        self.color = color
        isEnabledButton()
    }
}

extension GroupFormViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

private extension GroupFormViewController {
    func addConstraints() {
        view.addSubview(scrollView)
        [nameGroupTextField,
         colorLabel,
         nameLabel,
         doneButton,
         collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            scrollView.addSubview($0)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapGesture)
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.widthAnchor.constraint(equalTo: view.widthAnchor),
            
            nameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
            nameLabel.bottomAnchor.constraint(equalTo: nameGroupTextField.topAnchor, constant: -5),
            nameLabel.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            
            nameGroupTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 15),
            nameGroupTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 19),
            nameGroupTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -19),
            nameGroupTextField.heightAnchor.constraint(equalToConstant: 49),
            
            colorLabel.topAnchor.constraint(equalTo: nameGroupTextField.bottomAnchor, constant: 15),
            colorLabel.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: colorLabel.bottomAnchor, constant: 15),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 200),
            
            doneButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
            doneButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            doneButton.leadingAnchor.constraint(equalTo: nameGroupTextField.leadingAnchor),
            doneButton.trailingAnchor.constraint(equalTo: nameGroupTextField.trailingAnchor),
            doneButton.heightAnchor.constraint(equalToConstant: 60),
        ])
    }
}
