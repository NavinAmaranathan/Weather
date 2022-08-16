//
//  CityViewController.swift
//  Weather
//
//  Created by Navi on 02/08/22.
//

import UIKit

class CityViewController: UIViewController {
    // MARK: - Properties

    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var humidityLabel: UILabel!
    @IBOutlet var rainChancesLabel: UILabel!
    @IBOutlet var windInfoLabel: UILabel!
    var model: Place?
    var viewModel: CityViewModelData = CityViewModel()
    let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 0,
                                                                                          y: 0,
                                                                                          width: 50,
                                                                                          height: 50))
    
    // MARK: - Lifecycle methods

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.delegate = self
        setupUI()
    }
    
    // MARK: - Private methods

    private func setupUI() {
        startLoadingIndicator()
        viewModel.fetchForecast(for: model?.coord.latitude, and: model?.coord.longitude)
    }
    
    private func startLoadingIndicator() {
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = .large
        loadingIndicator.center = view.center
        loadingIndicator.backgroundColor = .systemBackground
        loadingIndicator.tintColor = .systemBlue
        loadingIndicator.startAnimating()
        view.addSubview(loadingIndicator)
    }
    
    func updateUI(with details: ForecastDetails) {
        temperatureLabel.text = details.temp
        humidityLabel.text = details.humidity
        windInfoLabel.text = details.windSpeed
        rainChancesLabel.text  = details.feelsLike
    }
    
    func stopLoadingIndicator() {
        loadingIndicator.stopAnimating()
        loadingIndicator.removeFromSuperview()
    }
}
