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
    let sizeChoice = MultiChoice()
    let creamAmtChoice = MultiChoice()
    let creamTypeChoice = MultiChoice()
    let sweetnerAmtChoice = MultiChoice()
    let sweetnerTypeChoice = MultiChoice()
    let temperatureChoice = MultiChoice()
    let addlNotes = FreeEntry()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeChoice.options = ["Large", "Small"]
        creamAmtChoice.options = ["Creamy", "Medium", "Light", "None"].reversed()
        creamTypeChoice.options = ["Cream", "Whole Milk", "2% Milk", "Low-Fat Milk",
        "Non-Fat Milk", "Almond Milk", "Soy Milk", "Vanilla Soy"]
        sweetnerAmtChoice.options = ["Sweet", "Medium", "Light", "None"].reversed()
        sweetnerTypeChoice.options = ["Sugar", "Honey", "Splenda", "Stevia", "Sweet'N Low", "Equal"]
        temperatureChoice.options = ["Hot", "Iced"]
        
        addlNotes.stringValue = "Additional Notes"
        
        sentence += "I'll have a "
        sentence += sizeChoice
        sentence += ", with "
        sentence += creamAmtChoice
        sentence += " "
        sentence += creamTypeChoice
        sentence += " and "
        sentence += sweetnerAmtChoice
        sentence += " "
        sentence += sweetnerTypeChoice
        sentence += ", "
        sentence += temperatureChoice
        sentence += ".\n\n"
        sentence += addlNotes
        
        
        sentence.resolutions += { if self.sweetnerAmtChoice.stringValue == "None" { self.sweetnerAmtChoice.stringValue = "No"; self.sweetnerTypeChoice.stringValue = "Sugar" }}
        sentence.resolutions += { if self.sweetnerAmtChoice.stringValue == "Sweet" { self.sweetnerAmtChoice.stringValue = "a lot of" }}
        sentence.resolutions += { if self.creamAmtChoice.stringValue == "None" { self.creamAmtChoice.stringValue = "No"; self.creamTypeChoice.stringValue = "Cream" }}
        sentence.resolutions += { if self.creamAmtChoice.stringValue == "Creamy" { self.creamAmtChoice.stringValue = "A lot of" }}
        
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
        layoutConstraints += "H:|-30-[sentenceView]-30-|".constraints(views: views)
        layoutConstraints += "V:|[sentenceView]|".constraints(views: views)
        view.addConstraints(layoutConstraints)
    }
    
}

extension SentenceViewController: InputControlDelegate {
    func showEditModal(control: ControlFragment) {
        guard let editVC = control.editView else { return }
        editVC.styleContext = sentenceView.styleContext
        editVC.modalPresentationStyle = .overCurrentContext
        present(editVC, animated: false)
    }
    
    func valueDidChange(control: ControlFragment, newValue: String) {
        updateInterface()
    }
}
