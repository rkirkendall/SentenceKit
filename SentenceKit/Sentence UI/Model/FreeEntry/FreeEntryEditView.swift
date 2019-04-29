//
//  FreeEntryEditView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/27/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
import Foundation

class FreeEntryEditViewController: EditBaseController {
    
    let textField = UITextField(autolayout: true)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        
        guard let styleContext = styleContext else { return }
        
        textField.font = styleContext.font
        textField.textColor = styleContext.controlColor
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.selectAll(self)
        textField.becomeFirstResponder()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        
        let layoutConstraints = [textField.widthAnchor.constraint(equalTo: view.widthAnchor),
                                 textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        
        view.addConstraints(layoutConstraints)
    }
}

extension FreeEntryEditViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else { return false }
        delegate?.changeStringVariable(text)
        dismiss(animated: false, completion: nil)
        return false
    }
    
}
