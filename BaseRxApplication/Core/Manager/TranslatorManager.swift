//
//  TranslatorManager.swift
//  BaseRxApplication
//
//  Created by Gary  Dos Santos on 02/03/2018.
//  Copyright © 2018. All rights reserved.
//

import Foundation

open class TranslatorManager {
    
    open static let settingsLanguageDidChangeNotifications = "SettingsLanguageDidChangeNotifications"
    open static let shared = TranslatorManager()
    open static let defaultAppLanguage: String = "es"
    
    open let languages = Bundle.main.localizations.filter { language -> Bool in
        return language.count == 2
    }
    
    open var currentLanguage = TranslatorManager.defaultLanguage()
    var currentBundle = Bundle.main
    var currentPluralBundle = Bundle.main
    var currentLocale = Locale.current
    
    open class func localeForCurrentLanguage() -> Locale {
        return Locale(identifier: TranslatorManager.shared.currentLanguage)
    }
    
    open class func currentLanguageLocalizedString(language: String) -> String {
        if let language = localeForCurrentLanguage().localizedString(forIdentifier: language) {
            return language.capitalized
        }
        return ""
    }
    
    /// Method to change the current language of the app
    /// - parameters:
    ///     - language : to change the language of the app
    open func changeLanguage(_ language: String) {
        setCurrentLanguage(language) 
        NotificationCenter.default.post(name: NSNotification.Name(TranslatorManager.settingsLanguageDidChangeNotifications), object: nil)
    }
    
    /// The app default language. If don't have one, return de device language
    // - returns: a String with the name of the default language
    open class func defaultLanguage() -> String {
        if let languageCode = Locale.current.languageCode, let language = availableLanguages().first(where: { $0 == languageCode }) {
            return language
        }
        return TranslatorManager.defaultAppLanguage
    }
    
    /// List of available languages listed on the Localizable.strings file
    /// - parameters:
    ///     - excludeBase : If excludeBase = true, don't include "Base" in available languages
    /// - returns: Array of available languages.
    open class func availableLanguages(_ excludeBase: Bool = true) -> [String] {
        var availableLanguages = Bundle.main.localizations
        if let indexOfBase = availableLanguages.index(of: "Base") , excludeBase == true {
            availableLanguages.remove(at: indexOfBase)
        }
        return availableLanguages
    }
    
    
    /// Get the current language's display name for a language.
    /// - parameters:
    ///     - language: Desired language.
    /// - returns: The localized string.
    open class func displayNameForLanguage(_ language: String) -> String {
        let locale : NSLocale = NSLocale(localeIdentifier: defaultLanguage())
        if let displayName = locale.displayName(forKey: NSLocale.Key.identifier, value: language) {
            return displayName
        }
        return String()
    }
    
    // ----------------------------
    // MARK: - Private Func 🔐
    // ----------------------------
    
    /// This prevents others from using the default '()' initializer for this class.
    private init() {
        setCurrentLanguage(currentLanguage)
    }
    
    /// Method to set the current language of the app
    /// - parameters:
    ///     - language : to change the language of the app
    private func setCurrentLanguage(_ language: String) {
        if var currentBundlePath = Bundle.main.path(forResource: "Localizable", ofType: "strings", inDirectory: nil, forLocalization: language) {
            let bundlePath: NSString = currentBundlePath as NSString
            currentBundlePath = bundlePath.deletingLastPathComponent as String
            
            if let newBundle = Bundle(path: currentBundlePath) {
                currentBundle = newBundle
            }
        }
        
        if var currentPluralBundlePath = Bundle.main.path(forResource: "Localizable", ofType: "stringsdict", inDirectory: nil, forLocalization: language) {
            let bundlePath: NSString = currentPluralBundlePath as NSString
            currentPluralBundlePath = bundlePath.deletingLastPathComponent as String
            
            if let newBundle = Bundle(path: currentPluralBundlePath) {
                currentPluralBundle = newBundle
            }
        }
        currentLanguage = language
    }
    
}
