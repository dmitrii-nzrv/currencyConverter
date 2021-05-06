//
//  currencyConversionManager.swift
//  currencyConverter
//
//  Created by Nadia Seleem on 05/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation

protocol CurrencyConversionManagerDelegate {
    func currencyConversionManager(_ currencyConversionManager:CurrencyConversionManager,
                                  currencyDidConvert conversionModel:ConversionModel)
    func currencyConversionManager(didFailWithErrorString error:String)
    func currencyConversionManager(didFailWithError error:Error)

}


struct CurrencyConversionManager{
    
    var money:Double?
    var fromCurrency:String = "AUD"
    var toCurrency:String = "AUD"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
       
   let apiKey = "770C71E4-4F50-4A05-AC86-ABE483B82E79"
    
    var delegate:CurrencyConversionManagerDelegate?
    
    mutating func setAmountOfMoneyToConvert(as value:Double ){
        money = value
        print(money!)
    }
    mutating func setCurrencyToConvertFrom(as currency:String ){
        fromCurrency = currency
    }
    mutating func setCurrencyToConvertTo(as currency:String ){
        toCurrency = currency

    }
    
    func convertCurrency(){
        guard let _ = money else{
           print("no money value")
            delegate?.currencyConversionManager(didFailWithErrorString: "money value is not set" )
            
            return
        }
        let urlString = "\(baseURL)/\(fromCurrency)/\(toCurrency)?apikey=\(apiKey)"
        print(urlString)
        performRequest(with:urlString)
        
    }
    
    func performRequest(with urlString:String){
        if let url = URL(string: urlString) {
            let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.currencyConversionManager(didFailWithError: error!)
                    return
                }
                if let data = data{
                    self.parseJSON(data)
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data:Data){
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(ConversionData.self, from: data)
            if let money = money{
                let fromCurrency = decodedData.asset_id_base
                let toCurrency = decodedData.asset_id_quote
                let exchangeRate = decodedData.rate
                let conversionModel = ConversionModel(money: money, fromCurrency: fromCurrency, toCurrency: toCurrency, exchangeRate: exchangeRate)
                delegate?.currencyConversionManager( self,
                                                     currencyDidConvert:conversionModel)
                
            }
        } catch {
            delegate?.currencyConversionManager(didFailWithError: error)
        }
        
    }
    
    
    
}
