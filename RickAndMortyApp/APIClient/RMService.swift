//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/28/23.
//

import UIKit

enum RMServiceError: Error {
    case failedToCreateRequest
    case failedToGetData
    case failedToFail
}

///  Primary API service to get data
final class RMService {
    
    /// Singleton pattern
    static let shared = RMService()
    private let cacheManager = RMAPICacheManager()
    
    private init() {}
    
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
        
        if let cachedData = cacheManager.cacheResponse(for: request.endPoint, url: request.url) {
            
            do {
                var count = 0
                let result = try JSONDecoder().decode(type.self, from: cachedData)
                print("DEBUG CONSOLE: USING CACHE API RESPONSE \(String(describing: count+=1))")
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
            return
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { [weak self] data, _, error in
            
            guard let data = data, error == nil else {
                completion(.failure(error ?? RMServiceError.failedToGetData))
                return
            }
            
            // Decode response
            do {
                let result = try JSONDecoder().decode(type.self, from: data)
                self?.cacheManager.setCache(
                    for: request.endPoint,
                    data: data,
                    url: request.url
                )
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
