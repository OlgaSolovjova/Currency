//
//  CurrenciesController.swift
//  currency
//
//  Created by Ольга on 01.07.2018.
//  Copyright © 2018 SO. All rights reserved.
//

import Foundation

class CurrenciesController {

    func loadCurrencies(competion: @escaping ([Currency]) -> Void) {
        ApiHttpRequest().loadCurrenciesData { result in
            do {
                let json = try result()
                DispatchQueue.main.async {
                    let currencies = json.compactMap { Currency.map($0) }
                    competion(currencies)
                }
            } catch let error {
                competion([])
                print("Loading currensies list from server failed with: ", error)
            }
        }
    }
}
