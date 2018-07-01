//
//  ModelJsonMapping.swift
//  currency
//
//  Created by Ольга on 30.06.2018.
//  Copyright © 2018 SO. All rights reserved.
//

import Foundation

typealias JSONObject = [AnyHashable: Any]
typealias JSON = [JSONObject]

protocol JSONMappable {
    static func map(_ jsonObject: JSONObject) -> Self?
}

extension Currency: JSONMappable {
    static func map(_ jsonObject: JSONObject) -> Currency? {
        let name = jsonObject["name"] as? String ?? ""
        let volume = jsonObject["volume"] as? Int ?? 0
        
        var amount: Double = 0
        if let priceObject = jsonObject["price"] as? JSONObject {
            amount = priceObject["amount"] as? Double ?? 0
        }
        
        return Currency(name: name, volume: volume, amount: amount)
    }
}
