//
//  Place.swift
//  Weather
//
//  Created by Navi on 03/08/22.
//

import Foundation
import CoreLocation

struct Place: Equatable, Codable {
    var name: String
    var coord: CLLocationCoordinate2D
    
    static func == (lhs: Place, rhs: Place) -> Bool {
        return lhs.name == rhs.name
    }
}

extension CLLocationCoordinate2D: Codable {
    public enum CodingKeys: String, CodingKey {
        case latitude
        case longitude
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(latitude, forKey: .latitude)
        try container.encode(longitude, forKey: .longitude)
        }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.init()
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}
