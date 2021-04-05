//
//  NetworkManager.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

class NetworkManager {
    
    static let shared = NetworkManager()
    private let baseUrl = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    let apiKey = "8ffda756f7cae9fc0afbfbeae03373d4"
    let end = "&language=en-US&page="
    var movieList: [MovieList] = []
    
    func getMovies(completed: @escaping (Result<MovieList, TDError>) -> Void) {
//        for page: Int,
        for page in 1...100 {
        let endpoint = baseUrl + apiKey
            + end + "\(page)"
        
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
                completed(.success(list))
                self.movieList.append(list)
            } catch {
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    }

}
