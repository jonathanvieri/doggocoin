//
//  ViewController.swift
//  DoggoCoin
//
//  Created by Jonathan Vieri on 09/06/22.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlets for the objects
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var attributionButton: UIButton!
    
    // Create an instance of CoinManager that will manage the fetching of current DogeCoin data
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        attributionButton.layer.cornerRadius = 10.0 // Make the attribution button round
        
        // Delegates and data source
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
    }

    // When the button containing the attribution is pressed it will
    // Go to the URL of Nomics website
    @IBAction func attributionPressed(_ sender: UIButton) {
        guard let url = URL(string: "https://nomics.com") else {return}
        UIApplication.shared.open(url)
    }
}


//MARK: - UIPickerView Data Source Methods

extension ViewController : UIPickerViewDataSource {
    
    // Number of rows we want in the picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // How many data in the picker
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
}

//MARK: - UIPickerView Delegate Methods

extension ViewController : UIPickerViewDelegate {
    
    // Will be called every row to ask the delegate for the row title
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // When user scrolls the picker and a row is selected
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

//MARK: - CoinManager Delegate Methods

extension ViewController : CoinManagerDelegate {
    
    // When the CoinManager receives the Price, it will call this method
    func didUpdatePrice(price: String, currency: String) {
        
        // Work on the main thread instead of the background thread
        DispatchQueue.main.async {
            self.priceLabel.text = price
            self.currencyLabel.text = currency
        }
    }
    
    // If it did fail with error given
    func didFailWithError(error: Error) {
        print(error)
    }
    
    
}
