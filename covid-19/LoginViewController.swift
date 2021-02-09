//
//  ViewController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 10/31/20.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet private var loginTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    
    private let validaion: ValidationService
    
    init(validation: ValidationService) {
        self.validaion = ValidationService()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.validaion = ValidationService()
        super.init(coder: coder)
    }
    
    //MARK:Save to UserDefaults
    private let lastUserLoginKey = "lastSuccesLogin"
    
    private func saveLastSuccessLoginInUserDefaults(login userLogin: String){ // Записывает последний усешный вход в программу
        UserDefaults.standard.setValue(userLogin, forKey: lastUserLoginKey)
    }
    
    private func loadLastSuccesLoginFromUserDefaults()->String!{ // Загружает последний успешный логин при вызове контроллера
        var lastLogin = ""
        if let lastLoginFromUserDefaults = UserDefaults.standard.string(forKey: lastUserLoginKey) {
            lastLogin = lastLoginFromUserDefaults
        }
        return lastLogin
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Add mainView on Screen
        let mainView = UIView(frame: CGRect(x: 0, y: self.view.frame.maxY, width: self.view.safeAreaLayoutGuide.layoutFrame.width, height: 0))
        mainView.backgroundColor = .white

        //add password
        loginTextField = UITextField(frame: CGRect(x: 87, y: 278, width: 200, height: 35))
        loginTextField.backgroundColor = .lightGray
        loginTextField.textColor = .white
        loginTextField.placeholder = "login"
        loginTextField.borderStyle = UITextField.BorderStyle.roundedRect
        loginTextField.keyboardType = UIKeyboardType.default
        loginTextField.returnKeyType = UIReturnKeyType.done
        loginTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        loginTextField.font = UIFont.boldSystemFont(ofSize: 21)
        loginTextField.addTarget(self, action: #selector(userLoginEdit), for: .editingChanged)
        mainView.addSubview(loginTextField)
        //add login
        passwordTextField = UITextField(frame: CGRect(x: 87, y: 353, width: 200, height: 35))
        passwordTextField.backgroundColor = .lightGray
        passwordTextField.textColor = .white
        passwordTextField.placeholder = "password"
        passwordTextField.borderStyle = UITextField.BorderStyle.roundedRect
        passwordTextField.keyboardType = UIKeyboardType.default
        passwordTextField.returnKeyType = UIReturnKeyType.done
        passwordTextField.clearButtonMode = UITextField.ViewMode.whileEditing
        passwordTextField.font = UIFont.boldSystemFont(ofSize: 21)
        passwordTextField.isSecureTextEntry = true
        passwordTextField.addTarget(self, action: #selector(userLoginEdit), for: .editingChanged)
        mainView.addSubview(passwordTextField)
        //add textButton
        loginButton = UIButton(frame: CGRect(x: 160, y: 450, width: 55, height: 26))
        loginButton.setTitleColor(.red, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.addTarget(self, action: #selector(userTryToLogin), for: .touchUpInside)
        mainView.addSubview(loginButton)
        
        self.view.addSubview(mainView)
        
        UIView.animate(withDuration: 1, animations: {
            mainView.layoutIfNeeded()
            mainView.frame = self.view.safeAreaLayoutGuide.layoutFrame 
        })
    }
    
    
    
    @objc private func userLoginEdit() {
     if !loginTextField.isEmpty && !passwordTextField.isEmpty{
            loginButton.isEnabled = true
        } else {
            loginButton.isEnabled = false
        }
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        if let lastLogin = loadLastSuccesLoginFromUserDefaults(){
            loginTextField.text = lastLogin
        }
        
        self.passwordTextField.text?.removeAll()
        self.loginButton.isEnabled = false
    }

    @objc private func userTryToLogin(){
        do{
        let username = try validaion.validateUsername(loginTextField.text)
        let _ = try validaion.validatePassword(passwordTextField.text)
 
        saveLastSuccessLoginInUserDefaults(login: username)

        let tabBarController = CustomTabBarController()
        tabBarController.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(tabBarController, animated: true)
  
    } catch {
        Messages().showAlertMsg(title: "Ошибка", message: error.localizedDescription, viewController: self)
    }
  }
}

extension UITextField {
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty {
             return false
        }
        return true
    }
}
