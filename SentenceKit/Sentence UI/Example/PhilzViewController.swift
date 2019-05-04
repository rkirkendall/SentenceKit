//
//  PhilzViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/28/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
import Modernistik

class PhilzViewController: SentenceViewController {
    let sizeChoice = MultiChoice()
    let creamAmtChoice = MultiChoice()
    let creamTypeChoice = MultiChoice()
    let sweetnerAmtChoice = MultiChoice()
    let sweetnerTypeChoice = MultiChoice()
    let temperatureChoice = MultiChoice()
    let addlNotes = FreeEntry()
    var controls = [ControlFragment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controls = [sizeChoice,
                    creamAmtChoice,
                    creamTypeChoice,
                    sweetnerAmtChoice,
                    sweetnerTypeChoice,
                    temperatureChoice,
                    addlNotes]
        
        let avenirNextBoldFont = UIFont(name: "AvenirNext-Bold", size: 42)
        let themeBrown = UIColor(red:0.25, green:0.15, blue:0.05, alpha:1.0)
        let transluscentTheme = themeBrown.opacity(0.65)
        let underlineColor = themeBrown.opacity(0.75)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        paragraphStyle.alignment = .center
        let style = Style(font: avenirNextBoldFont,
                                 controlColor: themeBrown,
                                 textColor: transluscentTheme,
                                 underlineColor: underlineColor,
                                 backgroundColor: UIColor(red:0.46, green:0.81, blue:0.65, alpha:1.0),
                                 paragraphStyle: paragraphStyle)
        
        view.backgroundColor = style.backgroundColor
        
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
        sentence.resolutions += { for c in self.controls { c.stringValue = c.stringValue.lowercased() } }
        
        sentenceView.styleContext = style
        sentenceView.sentence = sentence

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInterface()
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let views = ["sentenceView":sentenceView]
        var layoutConstraints = [NSLayoutConstraint]()
        layoutConstraints += "H:|-50-[sentenceView]-50-|".constraints(views: views)
        layoutConstraints += "V:|-130-[sentenceView]|".constraints(views: views)
        view.addConstraints(layoutConstraints)
    }
}
