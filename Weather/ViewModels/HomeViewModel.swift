//
//  HomeViewModel.swift
//  Weather
//
//  Created by Navi on 03/08/22.
//

import Foundation
import CoreLocation

protocol HomeViewModelDelegate: AnyObject {
    func didFind(placeName: String, for location: CLLocationCoordinate2D)
    func didFailToFindLocation()
}

protocol HomeViewModelData {
    var delegate: HomeViewModelDelegate? { get set }
    func findPlace(for location: CLLocationCoordinate2D)
    func fetchBookmarks() -> [Place]?
    func updateBookmarks(with places: [Place]) -> Bool
}

class HomeViewModel: HomeViewModelData {
    weak var delegate: HomeViewModelDelegate?
    
    func findPlace(for location: CLLocationCoordinate2D) {
        let geoCoder = CLGeocoder()
        let touchLocation = CLLocation(latitude: location.latitude,
                                       longitude: location.longitude)
        
        geoCoder.reverseGeocodeLocation(touchLocation, completionHandler: { [weak self] placeMarks, error  in
            
            var placeMark: CLPlacemark!
            placeMark = placeMarks?.first
            if let locationName = placeMark?.locality {
                self?.delegate?.didFind(placeName: locationName,
                                        for: location)
            } else {
                self?.delegate?.didFailToFindLocation()
            }
        })
    }
    
    func fetchBookmarks() -> [Place]? {

        if let data = UserDefaultsManager.shared.fetch() {
            do {
                let decoder = JSONDecoder()
                let places = try decoder.decode([Place].self, from: data)
                return places
            } catch {
                return nil
            }
        }
        return nil
    }
    
    func updateBookmarks(with places: [Place]) -> Bool {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(places)
            UserDefaultsManager.shared.save(data: data)
            return true
        } catch {
            return false
        }
    }
}
