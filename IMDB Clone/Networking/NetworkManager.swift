//
//  NetworkManager.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class NetworkManager {

    static let shared = NetworkManager()
    private init() { }

    func getMovies(completion: @escaping (Result<[Movie], ErrorMessage>) -> Void) {
        let endpoint = "https://api.themoviedb.org/3/movie/popular?api_key=b5cf63a4366b7eeb96503ea6c78879ab&language=en-US"

        guard let url = URL(string: endpoint) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidRequest))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.inavlidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let allMovies = try decoder.decode(Movies.self, from: data)
                let movie = allMovies.results
                completion(.success(movie))
            } catch {
                completion(.failure(.inavlidData))
            }
        }
        task.resume()
    }

    func getMovie(for movieID: Int, completion: @escaping (Result<SingleMovie, ErrorMessage>) -> Void) {
        let endpoint = "https://api.themoviedb.org/3/movie/\(movieID)?api_key=b5cf63a4366b7eeb96503ea6c78879ab&language=en-US"

        guard let url = URL(string: endpoint) else { return }

        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _ = error {
                completion(.failure(.invalidRequest))
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.inavlidData))
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let movie = try decoder.decode(SingleMovie.self, from: data)
                completion(.success(movie))
            } catch {
                completion(.failure(.inavlidData))
            }
        }
        task.resume()
    }
}

