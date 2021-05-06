//
//  ViewController.swift
//  currencyConverter
//
//  Created by Nadia Seleem on 05/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import UIKit

class CurrencyConversionViewController: UIViewController {


    var conversionManager = CurrencyConversionManager()
    
    @IBOutlet weak var amountOfMoneyTextField: UITextField!
    @IBOutlet weak var fromCurrencyPicker: UIPickerView!
    
    @IBOutlet weak var inputLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var toCurrencyPicker: UIPickerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        inputLabel.isHidden = true
        resultLabel.isHidden = true
        amountOfMoneyTextField.delegate = self
        fromCurrencyPicker.delegate = self
        toCurrencyPicker.delegate = self
        fromCurrencyPicker.dataSource = self
        toCurrencyPicker.dataSource = self
        conversionManager.delegate = self
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        amountOfMoneyTextField.endEditing(true)

        conversionManager.convertCurrency()
        
        inputLabel.isHidden = false
        resultLabel.isHidden = false
    }
    

}

 
extension CurrencyConversionViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }

    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            textField.placeholder = "enter an amount of money to convert"
            return false
        }
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if let textDouble = Double(textField.text!){
            conversionManager.setAmountOfMoneyToConvert(as:textDouble )
        }
    }
    
}


extension CurrencyConversionViewController:UIPickerViewDataSource,UIPickerViewDelegate{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
       return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return conversionManager.currencyArray.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        conversionManager.currencyArray[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
         amountOfMoneyTextField.endEditing(true)
        if pickerView === fromCurrencyPicker{
            conversionManager.setCurrencyToConvertFrom(as:conversionManager.currencyArray[row])
        }else if pickerView === toCurrencyPicker{
            conversionManager.setCurrencyToConvertTo(as:conversionManager.currencyArray[row])
       }
    }
}

extension CurrencyConversionViewController:CurrencyConversionManagerDelegate{
    func currencyConversionManager(_ currencyConversionManager: CurrencyConversionManager, currencyDidConvert conversionModel: ConversionModel) {
        DispatchQueue.main.async{
            self.inputLabel.text = "\(conversionModel.money) \(conversionModel.fromCurrency)="
            self.resultLabel.text = "\(String(format:"%0.02f",conversionModel.convertedMoney)) \(conversionModel.toCurrency)"
        }
    }
    
    func currencyConversionManager(didFailWithErrorString error: String) {
        print(error)
    }
    
    func currencyConversionManager(didFailWithError error: Error) {
        print(error)
    }
    
    
}
