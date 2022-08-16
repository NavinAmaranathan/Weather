//
//  AnnotationManager.swift
//  Weather
//
//  Created by Navi on 04/08/22.
//

import Foundation
import MapKit

final class AnnotationManager {
    // MARK: - Properties

    static let shared = AnnotationManager()
    private init() {}
    var annotations: [MKAnnotation] = []
    
    // MARK: - Methods

    func getBookmarkPins(for places: [Place]) -> [MKAnnotation] {
       return places.map {
            let annotation = MKPointAnnotation()
           annotation.coordinate = CLLocationCoordinate2D(latitude: $0.coord.latitude,
                                                          longitude: $0.coord.longitude)
            annotation.title = $0.name
            annotations.append(annotation)
            return annotation
        }
    }
    
    func removePin(at indexPath: Int, completion: (MKAnnotation) -> Void)  {
        let annotation = annotations[indexPath]
        annotations.remove(at: indexPath)
        completion(annotation)
    }
}
