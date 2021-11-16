//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Алексей Левченко on 15.09.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let currencyId: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
