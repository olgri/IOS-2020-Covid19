//
//  CasesDetailsViewController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 16.11.20.
//

import UIKit

class CasesDetailViewController: UIViewController {

var privateCase = Case(infected: 0, recovered: 0, country: "")
    let flagTextField = UITextField(frame: CGRect(x: 50, y: 50, width: 400, height: 100))
    let infectedTextField = UITextField(frame: CGRect(x: 100, y: 100, width: 400, height: 100))
    let recoveredTextField = UITextField(frame: CGRect(x: 100, y: 300, width: 400, height: 100))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(infectedTextField)
        
        self.view.addSubview(recoveredTextField)
//        countryLabel.text = "Text"
//        countryLabel.frame = CGRect(x: 10, y: 10, width: 100, height: 10)
//        self.view.addSubview(countryLabel)
            
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.view.backgroundColor = .white;
        self.title = privateCase.country

         let localeForCountry = locale(fullCountryName: privateCase.country)

        print(localeForCountry)
        if let flag = flagDictionary[localeForCountry] {
            print(flag)
            flagTextField.font = UIFont(name: "System", size: 20.0)
            flagTextField.text = flag
            } else
        {
            
        }
        
        
        if let infected = privateCase.infected{
            infectedTextField.text = "\(infected)" } else {
            infectedTextField.text = "N/A"
            }
        
        if let recovered = privateCase.recovered{
            recoveredTextField.text = "\(recovered)" }else{
            recoveredTextField.text = "N/A"
        }
    }
    
    private func locale(fullCountryName: String) -> String {
        let locales : String = ""
        for localeCode in NSLocale.isoCountryCodes {
            let identifier = NSLocale(localeIdentifier: localeCode)
            let countryName = identifier.displayName(forKey: NSLocale.Key.countryCode, value: localeCode)
            if fullCountryName.lowercased() == countryName?.lowercased() {
                return localeCode
            }
        }
        return locales
    }
    
    
    
   
}
extension Locale {
     func isoCode(for countryName: String) -> String? {
         return Locale.isoRegionCodes.first(where: { (code) -> Bool in
             localizedString(forRegionCode: code)?.compare(countryName, options: [.caseInsensitive, .diacriticInsensitive]) == .orderedSame
         })
     }
 }
