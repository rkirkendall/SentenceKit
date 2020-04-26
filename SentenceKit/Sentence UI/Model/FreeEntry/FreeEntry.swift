//
//  FreeEntry.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 3/26/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import Foundation
import UIKit

class FreeEntry: ControlFragment {
    private var _editViewController = FreeEntryEditViewController()
    private var _string: String?
    override var string: String {
        set {
            self._string = newValue
        }
        get {
            if let s = _string, s.trimmingCharacters(in: .whitespacesAndNewlines).count != 0 {
                return s
            }
            return placeholder
        }
    }
    
    override init() {
        super.init()
        _editViewController.delegate = self
        editView = _editViewController
    }
    
    required public init(tag: String) {
        super.init(tag: tag)
        _editViewController.delegate = self
        editView = _editViewController
    }
}

extension FreeEntry: EditVariableTextDelegate {
    func changeStringVariable(_ string: String) {
        _string = string
        delegate?.valueDidChange(control: self, newValue: string)
    }
}
