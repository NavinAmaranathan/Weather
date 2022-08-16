//
//  CityViewModel.swift
//  Weather
//
//  Created by Navi on 03/08/22.
//

import Foundation
import CoreLocation



protocol CityViewModelDelegate: AnyObject {
    func didFetch(forecast: ForecastDetails)
    func didFail()
}

protocol CityViewModelData {
    var delegate: CityViewModelDelegate? { get set }
    func fetchForecast(for: CLLocationDegrees?, and: CLLocationDegrees?)
}

class CityViewModel: CityViewModelData {
    weak var delegate: CityViewModelDelegate?
    var networkManager: NetworkManager
    private let tempConstant: Double = 273.15
    
    init(networkManager: NetworkManager = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    func fetchForecast(for lat: CLLocationDegrees?, and long: CLLocationDegrees?) {
        let apiKey = Constants.APIKey
        
        guard let lat = lat,
              let long = long,
              let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=\(apiKey)") else { return }
        
        networkManager.getCall(url: url,
                               resultType: TodaysForecast.self)
        { [weak self] result in
            switch result {
            case .success(let response):
                self?.parseResponse(forecast: response, completion: { details in
                    self?.delegate?.didFetch(forecast: details)
                })
            case .failure:
                self?.delegate?.didFail()
            }
        }
    }
    
    private func parseResponse(forecast: TodaysForecast, completion: (ForecastDetails) -> Void) {
        let temperature = String(format: "%.0f", forecast.main.temp - tempConstant) + " ℃"
        let humidity = String(forecast.main.humidity) + " %"
        let feelLike = forecast.weather.first?.weatherDescription.capitalized ?? "Data not available"
        let windSpeed = String(forecast.wind.speed) + " Kmph"
        
        completion(ForecastDetails(temp: temperature,
                                   humidity: humidity,
                                   feelsLike: feelLike,
                                   windSpeed: windSpeed))
    }
}
