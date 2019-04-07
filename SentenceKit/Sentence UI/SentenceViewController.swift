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
    
    var editView = BlurOverlay(autolayout: true)
    
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

        //typealias Resolution = () -> Void
        //var resolutions = [Resolution]()
        //resolutions += { if self.nameDropdown.stringValue == "Ricky" {/* change something}; change something else */ }
        //sentence.addResolutions(resolutions)
        
        sentenceView.sentence = sentence
        sentenceView.delegate = self
        
        view.addSubview(sentenceView)
        editView.isHidden = true
        view.addSubview(editView)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInterface()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let views = ["sentenceView":sentenceView, "edit":editView]
        var layoutConstraints = [NSLayoutConstraint]()
        layoutConstraints += "H:|[sentenceView]|".constraints(views: views)
        layoutConstraints += "V:|[sentenceView]|".constraints(views: views)
        layoutConstraints += "H:|[edit]|".constraints(views: views)
        layoutConstraints += "V:|[edit]|".constraints(views: views)
        view.addConstraints(layoutConstraints)
    }
    
    override func updateInterface() {
        super.updateInterface()
        sentenceView.layoutComponents()
    }
}

extension SentenceViewController: InputControlDelegate {
    func showEditModal(control: InputControl) {
        editView = control.editView
        editView.show(animate: true)
    }
    
    
    func valueDidChange(control: InputControl, newValue: String) {
        
    }
}
