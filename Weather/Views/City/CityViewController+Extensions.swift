//
//  CityViewController+Extensions.swift
//  Weather
//
//  Created by Navi on 03/08/22.
//

import UIKit

extension CityViewController: CityViewModelDelegate {
    
    func didFetch(forecast: ForecastDetails) {
        DispatchQueue.main.async { [weak self] in
            self?.updateUI(with: forecast)
            self?.stopLoadingIndicator()
        }
    }
    
    func didFail() {
        DispatchQueue.main.async { [weak self] in
            let alert  = UIAlertController(title: "Sorry, Unable to fetch details",
                                           message: "Try again after sometime.",
                                           preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .default,
                                          handler: { _ in
                self?.navigationController?.popViewController(animated: true)
            }))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
