//
//  Constants.swift
//  CurrencyUI
//
//  Created by mac on 8/5/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import UIKit

let BLACK_BG_COLOR = UIColor.black.withAlphaComponent(0.6).cgColor
let from = ""
let to = ""
let amount = ""

let API_KEY = "ce3e30efe9b04c54bdc8f8aeb2b258a6"

let SYMBOLS_URL = "http://data.fixer.io/api/symbols?access_key =\(API_KEY)"

let BASE_URL = "https://data.fixer.io/api/convert?access_key=\(API_KEY)"

let SYMBOLS = BASE_URL + "&base=GBP&symbols=USD,AUD,CAD,PLN,MXN"

let CONVERT = BASE_URL + "&from=\(from)&to=\(to)&amount=\(amount)"

typealias conversionReturnCompletion = (ConvertionResp?)->()
