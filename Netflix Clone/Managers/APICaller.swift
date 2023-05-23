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
    

// MARK: GET Trending Movies
    
    
    func getTrendingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/movie/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(TitleResponse.self, from:data)
                print("Trending Movies:")
                completion(.success(results.results))
            } catch {
                print("Error getting Trending Movies:")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
// MARK: GET Trending TV
    
    func getTrendingTv(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/trending/tv/day?api_key=\(Constants.API_KEY)") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(TitleResponse.self, from:data)
                print("Trending TV:")
                completion(.success(results.results))
            } catch {
                print("Error getting Trending TV:")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
// MARK: GET Upcoming Movies

    
    func getUpcomingMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        guard let url = URL(string: "\(Constants.baseURL)/3/movie/upcoming?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            
            guard let data = data, error == nil else {
                return
            }
            
            do {
//                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                let results = try JSONDecoder().decode(TitleResponse.self, from:data)
                print("Upcoming Movies:")
                completion(.success(results.results))
            } catch {
                print("Error getting Upcoming Movies:")
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
    
    
// MARK: GET Popular Movies

        
        func getPopularMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
            guard let url = URL(string: "\(Constants.baseURL)/3/movie/popular?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                
                guard let data = data, error == nil else {
                    return
                }
                
                do {
    //                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let results = try JSONDecoder().decode(TitleResponse.self, from:data)
                    print("Popular Movies:")
                    completion(.success(results.results))
                } catch {
                    print("Error getting Popular Movies:")
                    completion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
    
    
// MARK: GET Top Rated Movies

            
        func getTopRatedMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
            guard let url = URL(string: "\(Constants.baseURL)/3/movie/top_rated?api_key=\(Constants.API_KEY)&language=en-US&page=1") else {return}
            
            let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
                
                guard let data = data, error == nil else {
                    return
                }
                
                do {
    //                let results = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                    let results = try JSONDecoder().decode(TitleResponse.self, from:data)
                    print("Top Rated Movies:")
                    completion(.success(results.results))
                } catch {
                    print("Error getting Top Rated Movies:")
                    completion(.failure(APIError.failedToGetData))
                }
            }
            task.resume()
        }
}

