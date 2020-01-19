//
//  Movies.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

struct Movies: Codable {
    let results: [Movie]
}

 struct Movie: Codable {
     let id: Int
     let title: String
     let backdropPath: String?
     let posterPath: String?
     let overview: String
     let releaseDate: String
//     let genres: [MovieGenre]?
//     let videos: MovieVideoResponse?
     var posterURL: URL {
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
//
// struct MovieGenre: Codable {
//    let name: String
//}
//
// struct MovieVideoResponse: Codable {
//     let results: [MovieVideo]
//}
//
// struct MovieVideo: Codable {
//     let id: String
//     let key: String
//     let name: String
//     let site: String
//     let size: Int
//     let type: String
//
//     var youtubeURL: URL? {
//        guard site == "YouTube" else {
//            return nil
//        }
//        return URL(string: "https://www.youtube.com/watch?v=\(key)")
//    }
//}


