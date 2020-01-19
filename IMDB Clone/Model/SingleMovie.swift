//
//  SingleMovie.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import Foundation

struct SingleMovie: Codable {
    let adult: Bool
    let backdropPath: String
    let genres: [Genre]
    let overview: String
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool

}

struct Genre: Codable {
    let name: String
}
