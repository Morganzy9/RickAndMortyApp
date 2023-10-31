//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/28/23.
//

import UIKit

///  Primary API service to get data
final class RMService {
    
    /// Singleton pattern
    static let shared = RMService()
    
    private init() {}
    
    enum RMServiceError: Error {
        case failedToCreateRequest
        case failedToGetData
        case failedToFail
    }
    
    
    ///   Send API Call
    /// - Parameters:
    ///   - request:  Request instance
    ///   - type: Type of object that returns
    ///   - completion:  Return Data or Error
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = self.request(from: request) else {
            completion(.failure(RMServiceError.failedToCreateRequest))
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            
        }
        task.resume()
    }
    
    //  MARK: - Private
    
    private func request(from rmRequest: RMRequest) -> URLRequest? {
        guard let url = rmRequest.url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = rmRequest.httpMethod
        
        return request
    }
    
}
