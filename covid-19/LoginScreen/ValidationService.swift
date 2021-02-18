//
//  LoginFieldValidator.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 26.01.21.
//

import UIKit
struct ValidationService {

    func validateUsername (_ username: String?) throws -> String {
        guard let username = username else { throw ValidationError.usernameEmpty }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
        return username
    }

    func validatePassword (_ password: String?) throws -> String {
        guard let password = password else { throw ValidationError.passwordEmpty }
        guard password.count >= 6 else { throw ValidationError.passwordTooShort }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        return password
    }
}
enum ValidationError: LocalizedError{
    case passwordEmpty
    case passwordTooLong
    case passwordTooShort
    case usernameTooLong
    case usernameTooShort
    case usernameEmpty
    
    var errorDescription: String? {
        switch self {
        case .passwordEmpty:
            return "Пароль не задан"
        case .passwordTooLong:
            return "Пароль слишком длинный"
        case .passwordTooShort:
            return "Пароль слишком короткий"
        case .usernameTooLong:
            return "Логин слишком длинный"
        case .usernameTooShort:
            return "Логин слишком короткий"
        case.usernameEmpty:
            return "Не задано имя пользователя"
        }
    }
}
