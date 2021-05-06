//
//  ConversionData.swift
//  currencyConverter
//
//  Created by Nadia Seleem on 05/02/1442 AH.
//  Copyright © 1442 Nadia Seleem. All rights reserved.
//

import Foundation

struct ConversionData:Codable{
    let asset_id_base:String
    let asset_id_quote:String
    let rate:Double
}
