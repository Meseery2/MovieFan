//
//  UIFont+Ext.swift
//  MovieFan
//
//  Created by Mohammed ELMeseery on 6/20/20.
//  Copyright © 2020 Mohammed ELMeseery. All rights reserved.
//

import UIKit

enum Font: String {
    case ThemeLight     = "Montserrat-Light"
    case ThemeRegular   = "Montserrat-Regular"
    case ThemeMedium    = "Montserrat-Medium"
    case ThemeBold      = "Montserrat-Bold"
    case ThemeSemiBold  = "Montserrat-SemiBold"
    
    var name: String {
        return self.rawValue
    }
}

extension UIFont {
    
    static func themeFont(font: Font, size: CGFloat) -> UIFont {
        return UIFont(name: font.name, size: size)!
    }
    
    open class func themeLightFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.ThemeLight.name, size: size)!
    }
    
    open class func themeRegularFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.ThemeRegular.name, size: size)!
    }
    
    static func themeMediumFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.ThemeMedium.name, size: size)!
    }
    
    static func themeBoldFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.ThemeBold.name, size: size)!
    }
    
    static func themeSemiBoldFont(of size: CGFloat) -> UIFont {
        return UIFont(name: Font.ThemeSemiBold.name, size: size)!
    }
}
