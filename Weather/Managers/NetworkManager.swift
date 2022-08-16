//
//  NetworkManager.swift
//  Weather
//
//  Created by Navi on 02/08/22.
//

import Foundation

final class NetworkManager {

    // MARK: - Properties

    static let shared = NetworkManager()
    private init() {}
    
    // MARK: - Methods

    /// Used to fetch the data using an URLSession and parse the response to requested result type.
    func getCall<T: Decodable>(url: URL, resultType: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error!))
                return
            }
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch let error {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
