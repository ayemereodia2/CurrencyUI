//
//  FixerService.swift
//  CurrencyUI
//
//  Created by mac on 8/7/19.
//  Copyright © 2019 wox1. All rights reserved.
//

import Foundation
import Alamofire

class FixerService {
    
    func convert(payload:Query, completion:@escaping conversionReturnCompletion) {
        
        guard let url = URL(string: "\(BASE_URL)&from=\(payload.from)&to=\(payload.to)&amount=\(payload.amount)") else {return}
        print(url.absoluteString)
        
        Alamofire.request(url).responseJSON { (response) in
            
            if let error = response.result.error{
                debugPrint(error.localizedDescription)
                completion(nil)
                return
            }
            
            guard let data =  response.data else{
                return completion(nil)
            }
            let jsondecoder = JSONDecoder()
           
            do{
                
                let result = try jsondecoder.decode(ConvertionResp.self, from: data)
                completion(result)
                
            }
            catch
            {
                debugPrint(error.localizedDescription)
                completion(nil)
            }
        }
    }
    
}
