//
//  Styles.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 5/17/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

import UIKit
extension Style {
    
    static var Solstice: Style {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 38)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .left
        return Style(font: font,
                     controlColor: .white,
                     textColor: .white,
                     underlineColor: .white,
                     backgroundColor: .black,
                     paragraphStyle: paragraphStyle,
                     kern: 8)
    }
    
    static var CityCheap: Style {
        let font = UIFont(name: "HelveticaNeue-Light", size: 38)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .left
        return Style(font: font,
                     controlColor: .white,
                     textColor: .gray,
                     underlineColor: .red,
                     backgroundColor: .black,
                     paragraphStyle: paragraphStyle,
                     kern: nil)
    }
    
    static var CherryGordon: Style {
        let font = UIFont(name: "AvenirNext-DemiBold", size: 38)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .left
        return Style(font: font,
                     controlColor: .white,
                     textColor: .white,
                     underlineColor: .white,
                     backgroundColor: UIColor(red:1.00, green:0.13, blue:0.36, alpha:1.0),
                     paragraphStyle: paragraphStyle,
                     kern: nil)
    }
    
    static var ForgottenDre: Style {
        let font = UIFont(name: "SansSerifExbFLF", size: 38)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .left
        return Style(font: font,
                     controlColor: .white,
                     textColor: .gray,
                     underlineColor: .clear,
                     backgroundColor: UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0),
                     paragraphStyle: paragraphStyle,
                     kern: nil)
    }
    
    static var MintMojito: Style {
        let font = UIFont(name: "Jellee-Roman", size: 38)
        let themeBrown = UIColor(red:0.20, green:0.10, blue:0.05, alpha:1.0)
        let transluscentTheme = themeBrown.opacity(0.66)
        let underlineColor = themeBrown.opacity(0.75)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        return Style(font: font,
                     controlColor: themeBrown,
                     textColor: transluscentTheme,
                     underlineColor: underlineColor,
                     backgroundColor: UIColor(red:0.47, green:0.89, blue:0.61, alpha:1.0),
                     paragraphStyle: paragraphStyle,
                     kern: nil)
    }
}
