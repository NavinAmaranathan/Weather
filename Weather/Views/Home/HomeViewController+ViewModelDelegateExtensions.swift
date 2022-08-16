//
//  HomeViewController+ViewModelDelegateExtensions.swift
//  Weather
//
//  Created by Navi on 05/08/22.
//

import UIKit
import CoreLocation
import MapKit

extension HomeViewController: HomeViewModelDelegate {
    func didFind(placeName: String, for location: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = placeName
        mapView.addAnnotation(annotation)
        AnnotationManager.shared.annotations.append(annotation)
        places.append(Place(name: placeName,
                            coord: location))
        if viewModel.updateBookmarks(with: places) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func didFailToFindLocation() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Location not found!!",
                                          message: "Please try with some other place",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok",
                                          style: .destructive, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
}
