//
//  MultiChoice.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class MultiChoice: ControlFragment {
    
    var options: [String] {
        didSet {
            _editViewController.choices = self.options
        }
    }
    private var _editViewController = MultiChoiceEditViewController()
    private var _stringValue: String?
    override var stringValue: String {
        set {
            self._stringValue = newValue
        }
        get {
            if let s = _stringValue { return s }
            return options.count > 0 ? options[0] : emptyPlaceholder
        }
    }
    
    override init() {
        options = []
        super.init()
        _editViewController.choices = options
        _editViewController.delegate = self
        editView = _editViewController
    }
}

extension MultiChoice: EditVariableTextDelegate {
    func changeStringVariable(_ string: String) {
        _stringValue = string
        delegate?.valueDidChange(control: self, newValue: string)
    }
    
    
}
