//
//  PhilzViewController.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 4/28/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit

class PhilzViewController: SentenceViewController {
    let sizeChoice = MultiChoice(tag: "size")
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
        
        sizeChoice.options = ["Large", "Small"]
        creamAmtChoice.options = ["Creamy", "Medium", "Light", "None"]
        creamTypeChoice.options = ["Cream", "Whole Milk", "2% Milk", "Low-Fat Milk",
                                   "Non-Fat Milk", "Almond Milk", "Soy Milk", "Vanilla Soy"]
        sweetnerAmtChoice.options = ["Sweet", "Medium", "Light", "None"]
        sweetnerTypeChoice.options = ["Sugar", "Honey", "Splenda", "Stevia", "Sweet'N Low", "Equal"]
        temperatureChoice.options = ["Hot", "Iced"]
        
        sentence += "I'll have a "
        sentence += sizeChoice
        sentence += ", with "
        sentence += creamAmtChoice
        sentence += " "
        sentence += creamTypeChoice
        sentence += "\nand\n"
        sentence += sweetnerAmtChoice
        sentence += " "
        sentence += sweetnerTypeChoice
        sentence += ", "
        sentence += temperatureChoice
        sentence += ".\n\n"
        sentence += addlNotes
        
        sentence.resolutions += { if self.sweetnerAmtChoice.alias == "None" { self.sweetnerAmtChoice.alias = "No"; self.sweetnerTypeChoice.alias = "Sugar" }}
        sentence.resolutions += { if self.sweetnerAmtChoice.alias == "Sweet" { self.sweetnerAmtChoice.alias = "lots of" }}
        sentence.resolutions += { if self.creamAmtChoice.alias == "None" { self.creamAmtChoice.alias = "No"; self.creamTypeChoice.alias = "Cream" }}
        sentence.resolutions += { if self.creamAmtChoice.alias == "Creamy" { self.creamAmtChoice.alias = "lots of" }}
        sentence.resolutions += { for c in self.controls { c.alias = c.alias?.lowercased() } }
        
        let style = Style.MintMojito
        sentenceView.style = style
        view.backgroundColor = style.backgroundColor
        sentenceView.sentence = sentence

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateInterface()
    }
    
    override func updateInterface() {
        super.updateInterface()
        print("dictionary: ")
        print(sentence.dictionary.debugDescription)
    }
    
    override func setupConstraints() {
        super.setupConstraints()
        let views = ["sentenceView": sentenceView]
        var layoutConstraints = [NSLayoutConstraint]()
        layoutConstraints += "H:|-20-[sentenceView]-20-|".constraints(views: views)
        layoutConstraints += "V:|-30-[sentenceView]|".constraints(views: views)
        view.addConstraints(layoutConstraints)
    }
}
