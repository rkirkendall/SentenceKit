//
//  MultiChoice.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/12/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

public class MultiChoice: ControlFragment {
    
    var options: [String] {
        didSet {
            _editViewController.choices = self.options
        }
    }
    private var _editViewController = MultiChoiceEditViewController()
    
    override var alias: String? {
        get {
            return super.alias ?? (options.count > 0 ? options[0] : placeholder)
        }
        set {
            super.alias = newValue
        }
    }
        
    override init() {
        options = []
        super.init()
        _editViewController.choices = options
        _editViewController.delegate = self
        editView = _editViewController
    }
    
    required public init(tag: String) {
        options = []
        super.init(tag: tag)
        _editViewController.choices = options
        _editViewController.delegate = self
        editView = _editViewController
    }
}

extension MultiChoice: EditVariableTextDelegate {
    func changeStringVariable(_ string: String) {
        self.string = string
        delegate?.valueDidChange(control: self, newValue: string)
    }
    
}
