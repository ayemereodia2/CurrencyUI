//
//  ConvertionResp.swift
//  CurrencyUI
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import Foundation

struct ConvertionResp:Codable {
    let success:Bool
    let query:Query
    let info:Info
    let date:String
    let result:Decimal
    
    enum CodingKeys:String,CodingKey {
        case success
        case query
        case info
        case date
        case result
    }
}


struct Query:Codable {
    let from:String
    let to:String
    let amount:Decimal
    
    enum CodingKeys:String,CodingKey{
        case from
        case to
        case amount
    }
}

struct Info:Codable {
    let timestamp:Int32
    let rate: Decimal
    
    enum CodingKeys:String,CodingKey{
        case timestamp
        case rate
    }
}
