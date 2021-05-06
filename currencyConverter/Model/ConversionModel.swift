//
//  ConversionModel.swift
//  currencyConverter
//
//  Created by Nadia Seleem on 05/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation

struct ConversionModel{
    let money:Double
    let fromCurrency:String
    let toCurrency:String
    let exchangeRate:Double
    var convertedMoney:Double{
         return money * exchangeRate
    }
    
    init(money:Double, fromCurrency:String, toCurrency:String, exchangeRate:Double){
        self.money = money
        self.fromCurrency = fromCurrency
        self.toCurrency = toCurrency
        self.exchangeRate = exchangeRate
        
    }

}
