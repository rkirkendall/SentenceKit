//
//  ViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 2/18/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
import Modernistik

class SentenceViewController: ModernViewController {
    
    let sentence = Sentence()
    let sentenceView = SentenceView(autolayout: true)
    let nameDropdown = MultiChoice()
    let addressDropdown = MultiChoice()
    let visitReasonDropdown = MultiChoice()
    let dateDropdown = MultiChoice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameDropdown.options = ["Ricky", "Tenny"]
        addressDropdown.options = ["1755 Glendon Ave"]
        visitReasonDropdown.options = ["annual physical", "sick visit"]
        dateDropdown.options = ["Mar 13 at 4 PM"]
        
        sentence += nameDropdown
        sentence += " needs a doctor at "
        sentence += addressDropdown
        sentence += " for a "
        sentence += visitReasonDropdown
        sentence += " on "
        sentence += dateDropdown
        sentence += "."
        
        sentenceView.sentence = sentence
        sentenceView.delegate = self
        
        view.addSubview(sentenceView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInterface()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let views = ["sentenceView":sentenceView]
        var layoutConstraints = [NSLayoutConstraint]()
        layoutConstraints += "H:|[sentenceView]|".constraints(views: views)
        layoutConstraints += "V:|[sentenceView]|".constraints(views: views)
        view.addConstraints(layoutConstraints)
    }
    
    override func updateInterface() {
        super.updateInterface()
        sentenceView.layoutComponents()
    }
}

extension SentenceViewController: InputControlDelegate {
    func showEditModal(control: InputControl) {
        let editVC = control.editView
        editVC.styleContext = sentenceView.styleContext
        present(editVC, animated: true)
    }
    
    
    func valueDidChange(control: InputControl, newValue: String) {
        updateInterface()
    }
}
