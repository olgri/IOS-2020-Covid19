//
//  styledTextField.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 18.02.21.
//

import UIKit

class StyledTextField: UITextField{
   
    var isEmpty: Bool {
        if let text = self.text, !text.isEmpty { return false }
        return true
    }
    
    init(frame: CGRect, placeholder: String) {
        super.init(frame: CGRect(x: 87, y: 278, width: 200, height: 35))
        self.backgroundColor = .lightGray
        self.textColor = .white
        self.placeholder = placeholder
        self.borderStyle = .roundedRect
        self.keyboardType = .default
        self.returnKeyType = .done
        self.clearButtonMode = .whileEditing
        self.font = .boldSystemFont(ofSize: 21)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

