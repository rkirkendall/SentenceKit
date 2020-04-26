//
//  Styles.swift
//  SentenceKit
//
//  Created by Ricky Kirkendall on 5/17/19.
//  Copyright © 2019 Ricky Kirkendall. All rights reserved.
//

#if canImport(UIKit)
import UIKit

extension SentenceStyle {
    
    public static var Solstice: SentenceStyle {
        let font = UIFont(name: "HelveticaNeue-Bold", size: 32)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .left
        return SentenceStyle(font: font,
                     controlColor: .white,
                     textColor: .white,
                     underlineColor: .white,
                     backgroundColor: .black,
                     paragraphStyle: paragraphStyle,
                     kern: 8,
                     textCase: .upper)
    }
    
    public static var CityCheap: SentenceStyle {
        let font = UIFont(name: "HelveticaNeue-Light", size: 38)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 1
        paragraphStyle.alignment = .left
        return SentenceStyle(font: font,
                     controlColor: .white,
                     textColor: .gray,
                     underlineColor: .red,
                     backgroundColor: .black,
                     paragraphStyle: paragraphStyle,
                     kern: nil,
                     textCase: nil)
    }
    
    public static var Cherry: SentenceStyle {
        let font = UIFont(name: "AvenirNext-DemiBold", size: 38)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 0
        paragraphStyle.alignment = .left
        return SentenceStyle(font: font,
                     controlColor: .white,
                     textColor: .white,
                     underlineColor: .white,
                     backgroundColor: UIColor(red:1.00, green:0.13, blue:0.36, alpha:1.0),
                     paragraphStyle: paragraphStyle,
                     kern: nil,
                     textCase: nil)
    }
    
    public static var ForgottenDre: SentenceStyle {
        let font = UIFont(name: "SansSerifExbFLF", size: 38)!
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        paragraphStyle.alignment = .left
        return SentenceStyle(font: font,
                     controlColor: .white,
                     textColor: .gray,
                     underlineColor: .clear,
                     backgroundColor: UIColor(red:0.13, green:0.13, blue:0.13, alpha:1.0),
                     paragraphStyle: paragraphStyle,
                     kern: nil,
                     textCase: nil)
    }
    
    public static var MintMojito: SentenceStyle {
        let font = UIFont(name: "Helvetica", size: 40)!
        let themeBrown = UIColor(red:0.20, green:0.10, blue:0.05, alpha:1.0)
        let transluscentTheme = themeBrown.withAlphaComponent(0.66)
        let underlineColor = themeBrown.withAlphaComponent(0.75)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        paragraphStyle.alignment = .center
        return SentenceStyle(font: font,
                     controlColor: themeBrown,
                     textColor: transluscentTheme,
                     underlineColor: underlineColor,
                     backgroundColor: UIColor(red:0.47, green:0.89, blue:0.61, alpha:1.0),
                     paragraphStyle: paragraphStyle,
                     kern: nil,
                     textCase: nil)
    }
}
#endif
