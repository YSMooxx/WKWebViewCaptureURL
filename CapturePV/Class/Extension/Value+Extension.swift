//
//  Value+Extension.swift
//  UniversalRremote
//
//  Created by Hao Liu on 2024/8/6.
//

import Foundation

extension Int {
    
    func RW() -> Double {
        
        return Double(self) * RScreenW()
    }
    
    func RWI() -> Int {
        
        return Int(self) * Int(RScreenW())
    }
    
    func RH() -> Double {
        
        return Double(self) * RScreenH()
    }
    
    func RHI() -> Int {
        
        return Int(self) * Int(RScreenH())
    }
    
    func R(ratio:CGFloat) -> Double {
        
        return Double(self) * ratio
    }
}

extension Float {
    
    func RW() -> Double {
        
        return Double(self) * RScreenW()
    }
    
    func RWI() -> Int {
        
        return Int(self) * Int(RScreenW())
    }
    
    func RH() -> Double {
        
        return Double(self) * RScreenH()
    }
    
    func RHI() -> Int {
        
        return Int(self) * Int(RScreenH())
    }
    
    func R(ratio:CGFloat) -> Double {
        
        return Double(self) * ratio
    }
}

extension Double {
    
    func RW() -> Double {
        
        return Double(self) * RScreenW()
    }
    
    func RWI() -> Int {
        
        return Int(self) * Int(RScreenW())
    }
    
    func RH() -> Double {
        
        return Double(self) * RScreenH()
    }
    
    func RHI() -> Int {
        
        return Int(self) * Int(RScreenH())
    }
    
    func R(ratio:CGFloat) -> Double {
        
        return Double(self) * ratio
    }
}

extension CGFloat {
    
    func RW() -> Double {
        
        return Double(self) * RScreenW()
    }
    
    func RWI() -> Int {
        
        return Int(self) * Int(RScreenW())
    }
    
    func RH() -> Double {
        
        return Double(self) * RScreenH()
    }
    
    func RHI() -> Int {
        
        return Int(self) * Int(RScreenH())
    }
    
    func R(ratio:CGFloat) -> Double {
        
        return Double(self) * ratio
    }
}

