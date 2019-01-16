//
//  String+Localized.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 02/03/2018.
//  Copyright © 2018. All rights reserved.
//

import UIKit

extension String {
    
    var currentBundle: Bundle {
        return TranslatorManager.shared.currentBundle
    }
    
    var currentPluralBundle: Bundle {
        return TranslatorManager.shared.currentPluralBundle
    }
    
    public var localized: String {
        return NSLocalizedString(self, bundle: currentBundle, comment: "")
    }
    
    public func localizedString(replaceValues: Dictionary<String, String>) -> String {
        let originalString = NSMutableString(string: NSLocalizedString(self, bundle: currentBundle, comment: ""))
        
        for key in replaceValues.keys {
            let range = originalString.range(of: key)
            
            if range.location != NSNotFound {
                if let value = replaceValues[key] {
                    originalString.replaceCharacters(in: range, with: value)
                }
            }
        }
        
        return originalString as String
    }
    
    public func localizedPluralString(count: Int) -> String {
        return String.localizedStringWithFormat(NSLocalizedString(self, bundle: currentPluralBundle, comment: ""), count)
    }
    
}
