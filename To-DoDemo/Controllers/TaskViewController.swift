//
//  TaskViewController.swift
//  To-DoDemo
//
//  Created by  Даниил Хомяков on 18.06.2024.
//

import UIKit

final class TaskViewController: UIViewController {
    
    // MARK: - Properties
    var task: Task = Task()
    
    private let kStandartSpacing = 32.0
    private let kContentTextViewHeight = 100.0
    private let kSaveButtonWidth = 60.0
    
    // MARK: - Dependencies
    var tasksRepository: TasksRepository?
    
    // MARK: Views
    private let titleTextField: UITextField = {
        let field = UITextField()
        field.translatesAutoresizingMaskIntoConstraints = false
        field.font = UIFont.systemFont(ofSize: 17.0, weight: UIFont.Weight.semibold)
        field.textAlignment = .left
        field.textColor = .label
        field.backgroundColor = .secondarySystemBackground
        return field
    }()
    
    private let contentTextView: UITextView = {
        let view = UITextView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.font = UIFont.systemFont(ofSize: 13.0)
        view.textColor = .secondaryLabel
        view.backgroundColor = .secondarySystemBackground
        return view
    }()
    
    private let datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
        return picker
    }()
    
    let saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle(Constants.Strings.saveAction, for: .normal)
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .systemBackground
        datePicker.date = task.date
        view.addSubview(datePicker)
        titleTextField.text = task.title
        titleTextField.delegate = self
        view.addSubview(titleTextField)
        contentTextView.text = task.textDescription
        contentTextView.sizeToFit()
        contentTextView.delegate = self
        view.addSubview(contentTextView)
        view.addSubview(saveButton)
        let constraints = [
            titleTextField.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: kStandartSpacing),
            titleTextField.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: kStandartSpacing),
            contentTextView.leadingAnchor.constraint(equalTo: titleTextField.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            contentTextView.heightAnchor.constraint(equalToConstant: kContentTextViewHeight),
            
            datePicker.topAnchor.constraint(equalTo: contentTextView.bottomAnchor, constant: kStandartSpacing),
            datePicker.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            
            saveButton.centerXAnchor.constraint(equalTo: view.layoutMarginsGuide.centerXAnchor),
            saveButton.centerYAnchor.constraint(equalTo: view.layoutMarginsGuide.centerYAnchor),
            saveButton.widthAnchor.constraint(equalToConstant: kSaveButtonWidth)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func saveTask() {
        // End all editing to save changes
        titleTextField.endEditing(true)
        contentTextView.endEditing(true)
        datePicker.endEditing(true)
        
        // Save task
        tasksRepository?.save(task)
        
        // Close vc
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Handle user input

extension TaskViewController: UITextFieldDelegate, UITextViewDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) { // titleTextField
        guard let text = textField.text else {
            return
        }
        task.title = text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) { // contentTextView
        guard let text = textView.text else {
            return
        }
        task.textDescription = text
    }
    
    @objc func dateChanged() { // date
        task.date = datePicker.date
    }
}
