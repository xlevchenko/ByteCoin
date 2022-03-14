//
//  CoinManager.swift
//  ByteCoin
//

import Foundation
import UIKit

protocol CoinManagerDelegate {
    
    func didUpdateCoinRate(_ coinManager: CoinManager, coin: CoinModel)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "4FBAD14A-C7FE-4187-865A-DB3B9F2E20DB"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate: CoinManagerDelegate?
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        //1. Create a URL
        if let url = URL(string: urlString) {
            
            //2. Create a URLSession
            let session = URLSession(configuration: .default) // создаем ссесию
            
            //3. Give a sesion a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeDate = data {
                    if let coin = parseJSON(safeDate) {
                    self.delegate?.didUpdateCoinRate(self, coin: coin)
                    }
                }
            }
            //4. Start the task
            task.resume()
        }
    }
    
    func parseJSON(_ coinData: Data) -> CoinModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rate = decodedData.rate
            let currency = decodedData.asset_id_quote
            
            
           let coins = CoinModel(currencyId: currency, rate: rate)
            return coins
            
        } catch {
            delegate?.didFailWithError(error: error)
            
        }
        return nil
    }
}
