//
//  Element.swift
//  AC3.2-MidtermElements
//
//  Created by Maria on 12/8/16.
//  Copyright © 2016 C4Q. All rights reserved.
//

import Foundation


enum elementParseError: Error {
    case response, name, symbol, number, weight, meltingPoint, boilingPoint
}

class Element {
   
    let name: String
    let symbol: String
    let number: Int
    let weight: Double
    let meltingPoint: Int
    let boilingPoint: Int
    
    init(name: String, symbol: String, number: Int, weight: Double, meltingPoint: Int, boilingPoint: Int) {
        self.name = name
        self.symbol = symbol
        self.number = number
        self.weight = weight
        self.meltingPoint = meltingPoint
        self.boilingPoint = boilingPoint
    }
    
    static func getElements(from data: Data?) -> [Element]? {
        var elementArrayToReturn: [Element]? = []
        
        do {
            
            let jsonData = try JSONSerialization.jsonObject(with: data!, options: [])
            
            guard let response = jsonData as? [[String: Any]]
                else { throw elementParseError.response }
            
            for element in response {
                
                guard let returnedName = element["name"] as? String
                    else { throw elementParseError.name }
                guard let returnedSymbol = element["symbol"] as? String
                    else { throw elementParseError.symbol }
                guard let returnedNumber = element["number"] as? Int
                    else { throw elementParseError.number }
                guard let returnedWeight = element["weight"] as? Double
                    else { throw elementParseError.weight }
                if let returnedMeltingPoint = element["melting_c"] as? Int,
                    let  returnedBoilingPoint = element["boiling_c"] as? Int { let validElement = Element(name: returnedName, symbol: returnedSymbol, number: returnedNumber, weight: returnedWeight, meltingPoint: returnedMeltingPoint, boilingPoint: returnedBoilingPoint)
                    elementArrayToReturn?.append(validElement) } else { continue }
            }
            
            return elementArrayToReturn
            
        }
        catch {
            print("Problem casting json: \(error)")
        }
        
        
        return nil
    }
    
    
}
