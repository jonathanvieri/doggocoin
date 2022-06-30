//
//  CoinManager.swift
//  DoggoCoin
//
//  Created by Jonathan Vieri on 09/06/22.
//

import Foundation

// Protocol for delegates of CoinManager
protocol CoinManagerDelegate {
    func didUpdatePrice(price: String, currency: String)
    func didFailWithError(error: Error)
}

struct CoinManager {
    
    // Create a delegate that we can notify when the price is updated
    var delegate: CoinManagerDelegate?
    
    let baseURL = C.baseURL
    let apiKey = C.apiKey
    
    // Array containing currencies for conversion
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    //MARK: - Methods
    
    // Get the current Dogecoin price for the specified currency
    func getCoinPrice(for currency: String) {
        
        // Concatenate the base url with api key and selected currency
        let urlString = "\(baseURL)&convert=\(currency)&key=\(apiKey)"
        
        // Optional binding to unwrap the URL created from urlString
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)  // Create new URLSession object with default configuration
            let task = session.dataTask(with: url) { (data, response, error) in // Create a new task
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                }
                
                // Optional binding to unwrap the received data
                if let safeData = data {
                    if let dogecoinPrice = parseJSON(safeData) {
                        
                        // Round the price to two decimal place
                        let dogecoinPriceString = String(format: "%.2f", dogecoinPrice)
                        
                        self.delegate?.didUpdatePrice(price: dogecoinPriceString, currency: currency)
                    }
                }
            }
            task.resume()
        }
    }
    
    // Method to parse JSON which will return Dogecoin price in a double format
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        
        do {
            // Attempt to decode the data using CoinData struct
            let decodedData = try decoder.decode([CoinData].self, from: data).first
            
            // Get the latest price property from decoded data
            let lastPrice = decodedData!.price
            let lastPriceAsDouble = Double(lastPrice)
            
            return lastPriceAsDouble
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}
