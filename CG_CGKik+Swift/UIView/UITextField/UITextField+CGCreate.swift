//
//  UITextField+CGCreate.swift
//  QuickAskCommunity
//
//  Created by PCG on 2017/7/3.
//  Copyright © 2017年 ym. All rights reserved.
//

import UIKit

extension UITextField {
    
    convenience init(textColor: UIColor?, font: UIFont?) {
        
        self.init()
        self.font       = font
        self.textColor  = textColor
        
        self.clearButtonMode = .whileEditing
    }
    
    convenience init(attributedPlaceholder: NSAttributedString?, textColor: UIColor?, font: UIFont?) {
        
        self.init(textColor: textColor, font: font)
        self.attributedPlaceholder  = attributedPlaceholder
    }
    
    convenience init(placeholder: String?, textColor: UIColor?, font: UIFont?) {
        
        self.init(textColor: textColor, font: font)
        self.placeholder    = placeholder
    }
    
    convenience init(text: String?, placeholder: String?, textColor: UIColor?, font: UIFont?) {
        
        self.init(placeholder: placeholder, textColor: textColor, font: font)
        self.text = text
    }
    
    convenience init(attributedPlaceholder: NSAttributedString?, textColor: UIColor?, font: UIFont?, backgroundColor: UIColor?) {
        
        self.init(attributedPlaceholder: attributedPlaceholder, textColor: textColor, font: font)
        self.backgroundColor = backgroundColor
    }
    
}
