//
//  MovieCell.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit
import Kingfisher

class MovieCell: UITableViewCell {
    static let reuseId = "MovieCell"

    var movieImage = UIImageView()
    var movieTitle = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(movie: Movie) {
        movieImage.kf.setImage(with: movie.posterURL)
        movieTitle.text = movie.title
    }

    func configure() {
        addSubview(movieImage)
        addSubview(movieTitle)

        movieImage.layer.cornerRadius = 10
        movieImage.clipsToBounds = true

        selectionStyle = .none

        movieImage.translatesAutoresizingMaskIntoConstraints = false
        movieTitle.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieImage.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            movieImage.heightAnchor.constraint(equalToConstant: 120),
            movieImage.widthAnchor.constraint(equalToConstant: 80),
            movieTitle.centerYAnchor.constraint(equalTo: centerYAnchor),
            movieTitle.leadingAnchor.constraint(equalTo: movieImage.trailingAnchor, constant: 12),
            movieTitle.heightAnchor.constraint(equalToConstant: 80),
            movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12)
        ])
    }
}
