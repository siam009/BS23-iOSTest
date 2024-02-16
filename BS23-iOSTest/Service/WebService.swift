//
//  WebService.swift
//  BS23-iOSTest
//
//  Created by Arnab Ahamed Siam on 16/2/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum NetworkError: Error {
    case offline
    case noResponse
    case decodingError
    case unAuthorized
    case unknown
}

struct EndPoint {
    let url: URL
    let httpMethod: HTTPMethod
    let httpBody: Data?
}

class WebService {
    static func sendRequest<T: Decodable>(endPoint: EndPoint, responseModel: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
        var request = URLRequest(url: endPoint.url)
        request.httpMethod = endPoint.httpMethod.rawValue
        request.httpBody = endPoint.httpBody
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data, error == nil else {
                completion(.failure(NetworkError.offline))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noResponse))
                return
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedData = try? JSONDecoder().decode(responseModel.self, from: data) else {
                    completion(.failure(NetworkError.decodingError))
                    return
                }
                completion(.success(decodedData))
                
            case 401:
                completion(.failure(NetworkError.unAuthorized))
            default:
                completion(.failure(NetworkError.unknown))
            }
        }.resume()
    }
}
