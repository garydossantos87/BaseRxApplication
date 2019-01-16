//
//  BaseLogFormatter.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 09/03/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import CocoaLumberjack

open class BaseLogFormatter : NSObject, DDLogFormatter {
    
    public override init() {
        super.init()
    }
    
    public func format(message logMessage: DDLogMessage) -> String? {
        let logLevel: String
        switch logMessage.flag {
        case DDLogFlag.error:
            logLevel = "\n\n**ERROR ->"
        case DDLogFlag.warning:
            logLevel = "\n\n**WARNING ->"
        case DDLogFlag.info:
            logLevel = "\n\n**INFO -> "
        case DDLogFlag.debug:
            logLevel = "\n\n**DEBUG ->"
        default:
            logLevel = "\n\n**VERBOSE ->"
        }
        
        let time = logMessage.timestamp.toString()
        let message = logMessage.message
        let line = logMessage.line
        let fileName = logMessage.fileName
        var functionNameString = ""
        if let functionName = logMessage.function {
            functionNameString = " -> FUNCTION: \(functionName) "
        }
        
        return "\(logLevel) \n - TIME: \(time) \n - FILE: \(fileName)\(functionNameString)-> LINE: \(line) \n - MESSAGE: \n \(message)"
    }
    
}
