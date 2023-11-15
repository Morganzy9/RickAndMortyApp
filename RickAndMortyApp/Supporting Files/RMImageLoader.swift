//
//  RMImageLoader.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/14/23.
//

import Foundation

final class RMImageLoader {
    
    static let shared = RMImageLoader()
    
    private init() {}
    
    private var imageDataCache = NSCache<NSString, NSData>()
    
    
    
    /// Get image content URL
    /// - Parameters:
    ///   - url: source URL
    ///   - completion: CallBack
    func downloadImage(_ url: URL, completion: @escaping(Result<Data, Error>) -> Void) {
        let key = url.absoluteString as NSString
        
        if let data = imageDataCache.object(forKey: key) {
            print("DEBUG CONSOLE: \(key)")
            completion(.success(data as Data))
            return
        }
        
        let urlRequest = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            let value = data as NSData
            self.imageDataCache.setObject(value, forKey: key )
            completion(.success(data))
        }
        task.resume()
    }
    
}
