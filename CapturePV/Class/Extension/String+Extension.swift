//
//  String+Extension.swift
//  UniversalRremote
//
//  Created by Hao Liu on 2024/8/8.
//

import Foundation

extension String {
    
    func containsSubstring(substring: String, caseInsensitive: Bool = true) -> Bool {
        if caseInsensitive {
            return self.range(of: substring, options: .caseInsensitive) != nil
        } else {
            return self.contains(substring)
        }
    }
    
    var toBool: Bool? {
            let lowercasedSelf = self.lowercased()
            if lowercasedSelf == "true" || lowercasedSelf == "yes" || lowercasedSelf == "1" {
                return true
            } else if lowercasedSelf == "false" || lowercasedSelf == "no" || lowercasedSelf == "0" {
                return false
            } else {
                return nil
            }
        }
}
