//
//  HomeViewController+MapViewExtensions.swift
//  Weather
//
//  Created by Navi on 04/08/22.
//

import MapKit

// MARK: - MapView implementations
extension HomeViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else {
            return nil
        }
        
        let reuseId = "pin"
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        guard let pinView = pinView else {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView?.canShowCallout = true
            pinView?.rightCalloutAccessoryView = UIButton(type: .infoDark)
            return pinView
        }
        pinView.annotation = annotation
        
        return pinView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            guard let title = view.annotation?.title ?? "",
                  let cityVC = storyboard?.instantiateViewController(withIdentifier: "CityVC") as? CityViewController,
                  let coord = view.annotation?.coordinate
            else {
                return
            }
            
            let tappedLocation = Place(name: title,
                                       coord: coord)
            
            if places.contains(tappedLocation) {
                cityVC.title = title
                cityVC.model = tappedLocation
                navigationController?.pushViewController(cityVC, animated: true)
            }
        }
    }
}
