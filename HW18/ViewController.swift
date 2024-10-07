//
//  ViewController.swift
//  HW18
//
//  Created by Максим Громов on 19.08.2024.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    lazy var textField = UITextField()
    lazy var button = UIButton()
    lazy var label = UILabel()
    lazy var stackView = UIStackView()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    var centerYConstraint: NSLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        centerYConstraint = stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50)
        centerYConstraint?.isActive = true
        bottomConstraint = stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50)
        stackView.spacing = 15
        
        stackView.addArrangedSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        label.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        label.textAlignment = .center
        label.text = "Text will be displayed here"
        
        stackView.addArrangedSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 30).isActive = true
        textField.placeholder = "Enter text"
        textField.textAlignment = .center
        textField.borderStyle = .roundedRect
        textField.delegate = self
        
        stackView.addArrangedSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.setTitle("Press me", for: .normal)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemCyan, for: .highlighted)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardAppeared), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
    }
    
    @objc func keyboardHidden(){
        self.bottomConstraint?.isActive = false
        self.centerYConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        
    }
    
    @objc func keyboardAppeared(_ notification: Notification){
        guard let value = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let height = value.cgRectValue.height + 10
        
        self.centerYConstraint?.isActive = false
        self.bottomConstraint?.constant = -height
        self.bottomConstraint?.isActive = true
        
        UIView.animate(withDuration: 0.3) {
            self.stackView.layoutIfNeeded()
        }
        
    }
    
    @objc func buttonPressed(){
        label.text = textField.text!
        textField.text = ""
    }
    
    @objc func hideKeyboard(){
        textField.resignFirstResponder()
        keyboardHidden()
    }
}

#Preview{
    ViewController()
}
