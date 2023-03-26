//
//  APIClient.swift
//  RobustaTaskIOS
//
//  Created by Zyad Galal on 26/03/2023.
//

import Foundation

struct APIClient {
    static func performRequest<model: Codable>(model: model.Type, url: APIPaths, completion: @escaping (Result<model, Error>) -> Void) {
        guard let url = URL(string: Constants.basseURL + url.path)else {
            // Error: invalid URL
            completion(.failure(ApiError.invalidURL))
            return}
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                // Error: request Error
                completion(.failure(error))
            }
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                // Error: invalid HTTP status
                completion(.failure(ApiError.invalidHTTP))
                return
            }
            guard let data = data else {
                // Error: invalid Data, get null
                completion(.failure(ApiError.missingData))
                return
            }
            do {
                let decoder = JSONDecoder()
                let model = try decoder.decode(model.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch let codableError {
                DispatchQueue.main.async {
                completion(.failure(codableError))
                }
            }
        }.resume()
    }
}

enum ApiError: Swift.Error {
    case invalidURL
    case invalidHTTP
    case missingData
}
