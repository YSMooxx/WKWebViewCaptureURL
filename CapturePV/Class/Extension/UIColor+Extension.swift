//
//  UIColor+Extension.swift
//  UniversalRremote
//
//  Created by Hao Liu on 2024/8/6.
//

import UIKit

extension UIColor {
    
    class func colorWithHex(hexStr:String,alpha:Float = 1) -> UIColor {
        
        var  cStr = hexStr.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines).uppercased() as NSString
        
        if(cStr.length < 6) {
            
            return UIColor.clear
        }
        
        if(cStr.hasPrefix("0x")) {
            
            cStr = cStr.substring(from: 2) as NSString
        }
        
        if(cStr.hasPrefix("#")) {
            
            cStr = cStr.substring(from: 1) as NSString
        }
        
        if(cStr.length != 6) {
            
            return UIColor.clear
        }
        
        let rStr = (cStr as NSString).substring(to: 2)
        let gStr = ((cStr as NSString).substring(from: 2) as NSString).substring(to: 2)
        let bStr = ((cStr as NSString).substring(from: 4) as NSString).substring(to: 2)
        
        var r:UInt64 = 0
        var g:UInt64 = 0
        var b:UInt64 = 0
        
        Scanner.init(string: rStr).scanHexInt64(&r)
        Scanner.init(string: gStr).scanHexInt64(&g)
        Scanner.init(string: bStr).scanHexInt64(&b)
        
        return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(alpha))   
    }
    
}
