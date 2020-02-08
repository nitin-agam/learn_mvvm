//
//  BindingTextField.swift
//  GoodWeather
//
//  Created by Nitin A on 30/01/20.
//  Copyright © 2020 Nitin A. All rights reserved.
//

import UIKit

class BindingTextField: UITextField {
    
    var textChangedHandler: (String) -> () = { _ in }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    func initialSetup() {
        self.addTarget(self, action: #selector(textFieldTextChanged(_:)), for: .editingChanged)
    }
    
    @objc private func textFieldTextChanged(_ textField: UITextField) {
        if let text = textField.text {
            textChangedHandler(text)
        }
    }
    
    func bind(_ callBack: @escaping (String) -> ()) {
        self.textChangedHandler = callBack
    }
}
