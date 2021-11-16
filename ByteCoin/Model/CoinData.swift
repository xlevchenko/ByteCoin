//
//  CoinData.swift
//  ByteCoin
//
//  Created by Алексей Левченко on 15.09.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation
import UIKit

struct CoinData: Codable {
    let asset_id_quote: String
    let rate: Double
}
