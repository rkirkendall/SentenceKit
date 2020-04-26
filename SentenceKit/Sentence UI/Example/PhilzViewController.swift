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
    let sizeChoice = MultiChoice(tag: "size")
    let cf = ControlFragment(tag: "d")
    let creamAmtChoice = MultiChoice("creamAmt")
    let creamTypeChoice = MultiChoice("creamType")
    let sweetnerAmtChoice = MultiChoice("sweetnerAmt")
    let sweetnerTypeChoice = MultiChoice("sweetnerType")
    let temperatureChoice = MultiChoice("temp")
    let addlNotes = FreeEntry("addlNotes")
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
        
        //addlNotes.stringValue = "a    a"
        
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
        
        sentence.resolutions += { if self.sweetnerAmtChoice.string == "None" { self.sweetnerAmtChoice.string = "No"; self.sweetnerTypeChoice.string = "Sugar" }}
        sentence.resolutions += { if self.sweetnerAmtChoice.string == "Sweet" { self.sweetnerAmtChoice.string = "a lot of" }}
        sentence.resolutions += { if self.creamAmtChoice.string == "None" { self.creamAmtChoice.string = "No"; self.creamTypeChoice.string = "Cream" }}
        sentence.resolutions += { if self.creamAmtChoice.string == "Creamy" { self.creamAmtChoice.string = "A lot of" }}
        sentence.resolutions += { for c in self.controls { c.string = c.string.lowercased() } }
        
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
