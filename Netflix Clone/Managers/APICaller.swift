//
//  APICaller.swift
//  Netflix Clone
//
//  Created by J on 5/21/23.
//

import Foundation

struct Constants {
    static let API_KEY = ""
    static let baseURL = "https://api.themoviedb.org"
}

enum APIError: Error {
    case failedToGetData
}

class APICaller {
    static let shared = APICaller()
    
    
    func getTrendingMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/all/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(TrendingMoviesResponse.self, from:data)
                print("Trending Movies:")
                completion(.success(results.results))
            } catch {
                print("Error getting Trending Movies:")
                completion(.failure(error))
            }
        }
        
        task.resume()
        
    }
}

