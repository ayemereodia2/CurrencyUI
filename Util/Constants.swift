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

let BASE_ULR = "https://swapi.co/api/latest?access_key=\(API_KEY)"

let SYMBOLS = BASE_ULR + "&base=GBP&symbols=USD,AUD,CAD,PLN,MXN"

let CONVERT = BASE_ULR + "&from=\(from)&to=\(to)&amount=\(amount)"

//typealias personReturnCompletion = (Person?)->()

