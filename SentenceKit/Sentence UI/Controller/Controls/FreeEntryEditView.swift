//
//  FreeEntryEditView.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/27/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
import Foundation

open class FreeEntryEditViewController: EditBaseController {
    
    let textField = UITextField(autolayout: true)
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textField)
        textField.backgroundColor = .clear
        textField.textAlignment = .center
        textField.returnKeyType = .done
        textField.delegate = self
        
        guard let style = style else { return }
        
        textField.font = style.font
        textField.textColor = style.controlColor
        
    }
    
    override open func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textField.selectAll(self)
        textField.becomeFirstResponder()
    }
    
    override open func setupConstraints() {
        super.setupConstraints()
        
        let layoutConstraints = [textField.widthAnchor.constraint(equalTo: view.widthAnchor),
                                 textField.centerYAnchor.constraint(equalTo: view.centerYAnchor)]
        
        view.addConstraints(layoutConstraints)
    }
}

extension FreeEntryEditViewController: UITextFieldDelegate {
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let text = textField.text else { return false }
        delegate?.editController(self, didReturnWithValue: text)
        dismiss(animated: false, completion: nil)
        return false
    }
    
}
