//
//  LoginViewControllerChecks.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 12.01.21.
//

import Foundation

class CheckForValid{
    func isLoginAndPasswordEmpty(loginText: String, passwordText: String) -> Bool {
        if (loginText != "") && (passwordText != "") {
            return true
        } else
        {
           return false
        }
    }
    func isPasswordCountMoreThan7(passwordText: String) -> Bool {
        if passwordText.count>8{
            return true
        } else
        {
            return false
        }
    }
}
