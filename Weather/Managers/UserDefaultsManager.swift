//
//  UserDefaultsManager.swift
//  Weather
//
//  Created by Navi on 05/08/22.
//

import Foundation

final class UserDefaultsManager {
    
    // MARK: - Properties
    
    static let shared = UserDefaultsManager()
    private init() {}
    private let ud = UserDefaults.standard
    
    // MARK: - Methods

    func save(data: Data) {
        ud.set(data, forKey: "Bookmarks")
    }
    
    func fetch() -> Data? {
        return ud.value(forKey: "Bookmarks") as? Data
    }
    
    func removeAll() {
        ud.removeObject(forKey: "Bookmarks")
    }
}
