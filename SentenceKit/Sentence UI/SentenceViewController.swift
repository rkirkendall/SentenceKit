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
    let creamAmountChoice = MultiChoice()
    let creamTypeChoice = MultiChoice()
    let sweetnerAmountChoice = MultiChoice()
    let sweetnerTypeChoice = MultiChoice()
    let temperatureChoice = MultiChoice()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sizeChoice.options = ["Large", "Small"]
        creamAmountChoice.options = ["Creamy", "Medium", "Light", "None"]
        creamTypeChoice.options = ["Cream", "Whole Milk", "2% Milk", "Low-Fat Milk",
        "Non-Fat Milk", "Almond Milk", "Soy Milk", "Vanilla Soy"]
        sweetnerAmountChoice.options = ["Sweet", "Medium", "Light", "None"]
        sweetnerTypeChoice.options = ["Sugar", "Honey", "Splenda", "Stevia", "Sweet'N Low", "Equal"]
        temperatureChoice.options = ["Hot", "Iced"]
        
        sentence += "I'll have a "
        sentence += sizeChoice
        sentence += ", with "
        sentence += creamAmountChoice
        sentence += " "
        sentence += creamTypeChoice
        sentence += " and "
        sentence += sweetnerAmountChoice
        sentence += " "
        sentence += sweetnerTypeChoice
        sentence += ", "
        sentence += temperatureChoice
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
        editVC.modalPresentationStyle = .overCurrentContext
        present(editVC, animated: false)
    }
    
    
    func valueDidChange(control: InputControl, newValue: String) {
        updateInterface()
    }
}
