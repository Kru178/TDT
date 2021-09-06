//
//  NetworkManager.swift
//  TDT
//
//  Created by Sergei Krupenikov on 30.03.2021.
//

import UIKit

protocol NetworkControllerDelegate {
    func get(resourceType: String, completed: @escaping (Result<Data, TDError>) -> Void)
}

class NetworkController {
    
    static let shared = NetworkController()
    private let baseUrl = "https://api.themoviedb.org/3/movie/"
    private let topRated = "top_rated?"
    private let apiKey = "api_key=8ffda756f7cae9fc0afbfbeae03373d4"
    private let end = "&language=en-US&year=2019&page="
    
    func getMovies(anObject: NetworkControllerDelegate, for page: Int,
                   completed: @escaping (Result<MovieList, TDError>) -> Void) {
        let endpoint = baseUrl + topRated + apiKey + end + "\(page)"
        
        anObject.get(resourceType: endpoint){ result in
            
            switch result {
            case .failure(let error):
                completed(.failure(error))
                
            case .success(let data):
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
        }
    }
    
    func getMovie(anObject: NetworkControllerDelegate, for id: String, completed: @escaping (Result<Movie, TDError>) -> Void) {
        let endpoint = baseUrl + id + apiKey
        
        anObject.get(resourceType: endpoint) { result in
            switch result {
            case .failure(let error):
                completed(.failure(error))
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movie = try decoder.decode(Movie.self, from: data)
                    completed(.success(movie))
                } catch {
                    completed(.failure(.invalidData))
                }
            }
        }
    }
}

extension URLSession : NetworkControllerDelegate {
    
    func get(resourceType: String, completed: @escaping (Result<Data, TDError>) -> Void) {
        guard let url = URL(string: resourceType) else {
            completed(.failure(.invalidURL))
            return
        }
        let request = URLRequest(url: url)
        let newTask = URLSession.shared.dataTask(with: request)
        { (possibleData, possibleResponse, possibleError) in
            
            guard possibleError == nil else {
                completed(.failure(.unableToComplete))
                return
            }
            guard let response = possibleResponse as? HTTPURLResponse else {
                completed(.failure(.invalidResponse))
                return
            }
            guard (200...299).contains(response.statusCode) else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let receivedData = possibleData else {
                completed(.failure(.invalidData))
                return
            }
            completed(.success(receivedData))
        }
        newTask.resume()
    }
    
}
