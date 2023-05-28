//
//  APICaller.swift
//  Netflix Clone
//
//  Created by J on 5/21/23.
//

import Foundation

struct Constants {

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
    
    // MARK: Get Discover Movies
    
    func getDiscoverMovies(completion: @escaping (Result<[Title], Error>) -> Void) {
        // https://api.themovidedb.org/3/discover/movie?api_key=<<api_key>>&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&width_watch_monetization_types=flatrate
        guard let url = URL(string: "\(Constants.baseURL)/3/discover/movie?api_key=\(Constants.API_KEY)&language=en_US&page&sort_by=popularity.desc&include_adult=false&include_video=false&page=1&width_watch_monetization_types=flatrate") else {return}
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) {data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
                
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        
        task.resume()
    }
    
    func search(with query: String, completion: @escaping (Result<[Title], Error>) -> Void) {
        
        // format query
        // Example Output --> "test%2Ftest"
        guard let query = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        
        guard let url = URL(string: "\(Constants.baseURL)/3/search/movie?api_key=\(Constants.API_KEY)&query=\(query)") else { return }
        
        let task = URLSession.shared.dataTask(with: URLRequest(url: url)) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let results = try JSONDecoder().decode(TitleResponse.self, from: data)
                completion(.success(results.results))
            } catch {
                completion(.failure(APIError.failedToGetData))
            }
        }
        task.resume()
    }
}

