//
//  ViewController.swift
//  ToDoEveryday
//
//  Created by Rahul Singh on 24/03/24.
//

import UIKit

class ViewController: UIViewController {
    private lazy var textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .black
        textField.tintColor = .systemOrange
        textField.textColor = .white
        return textField
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let userInputRepository: UserInputRepository = UserInputCoreDataRepository(modelName: "ToDoEveryday")
    private var userInputs: [UserInput] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        addAutolayoutConstraints()
        setDefaulltValues()
    }

    private func setupView() {
        textField.delegate = self
        tableView.dataSource = self
        tableView.register(TaskListCell.self, forCellReuseIdentifier: "TaskListCell")

        view.addSubview(textField)
        view.addSubview(tableView)
    }
    
    private func addAutolayoutConstraints() {
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            tableView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setDefaulltValues() {
        reloadData()
    }
    
    private func reloadData() {
        userInputs = userInputRepository.getAllUserInputs()
        tableView.reloadData()
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, !text.isEmpty else {
            return false
        }
        
        userInputRepository.save(value: text)
        textField.text = nil // Clear the text field
        textField.resignFirstResponder() // Dismiss the keyboard
        
        // Refresh table view with updated data
        reloadData()
        
        return true
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userInputs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "UserInputCell")
        let userInput = userInputs[indexPath.row]
        cell.textLabel?.text = userInput.value
        return cell
    }
}
