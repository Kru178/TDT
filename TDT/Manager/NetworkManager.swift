//
//  NetworkManager.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.themoviedb.org/3/movie/popular?"
    let apiKey = "api_key=8ffda756f7cae9fc0afbfbeae03373d4"
    let end = "&language=en-US&year=2019&page="
    
    func getMovies(for page: Int, completed: @escaping (Result<MovieList, TDError>) -> Void) {
        let endpoint = baseUrl + apiKey + end + "\(page)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let list = try decoder.decode(MovieList.self, from: data)
                DispatchQueue.main.async {
                    completed(.success(list))
                }
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
}
