//
//  ApiHttpRequest.swift
//  currency
//
//  Created by Ольга on 30.06.2018.
//  Copyright © 2018 SO. All rights reserved.
//

import Foundation

typealias HttpRequestClosure = () throws -> JSON
typealias ThrowsCompletion = (HttpRequestClosure) -> Void

class ApiHttpRequest {

    func loadCurrenciesData(completion: ThrowsCompletion?) {
        guard let currencyURL = URL(string: "http://phisix-api3.appspot.com/stocks.json") else { return }

        URLSession.shared.dataTask(with: currencyURL, completionHandler: { data, response, error in
            guard let data = data,
                  let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONObject,
                  let result = jsonObject?["stock"] as? JSON
            else {
                completion? { return [] }
                if let error = error { print(error.localizedDescription) }
                return
            }
            
            DispatchQueue.main.async {
                completion? { return result }
            }

        }).resume()
    }
}
