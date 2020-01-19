//
//  MovieDetailViewController.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movieID: Int!
    let padding: CGFloat = 15
    let topMargin: CGFloat = 10
    let movieImage = UIImageView()
    let trailerButton = UIButton()
    let movieTitle = UILabel()
    let genresLabel = UILabel()
    let genresContentLabel = UILabel()
    let dateTitleLabel = UILabel()
    let date = UILabel()
    let overviewTitle = UILabel()
    let overview = UILabel()
    let genres: [Genre] = []
    let baseImagePath = "https://image.tmdb.org/t/p/original/"

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        getMovie()
        configureMovieImage()
        configureMovieTitle()
        configureGenre()
        configureDate()
        configureOverview()

    }

    func getMovie() {
        showLoadingView()
        NetworkManager.shared.getMovie(for: movieID) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {
            case .success(let movie):
                let imageUrl = URL(string: self.baseImagePath + movie.backdropPath)
                DispatchQueue.main.async {
                    self.title = movie.title
                    self.movieImage.kf.setImage(with: imageUrl)
                    self.movieTitle.text = movie.title
                    self.formatDate(for: movie.releaseDate)
                    self.overview.text = movie.overview

                    let moviesGenres = movie.genres.map {($0.name)}
                    self.genresContentLabel.text = moviesGenres.joined(separator: ", ")


                }

            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func formatDate(for date: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyy-MM-dd"

        if let date = formatter.date(from: date) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateFormat = "dd-MM-yyyy"
            self.date.text = displayFormatter.string(from: date)
        }
    }

    func configureMovieImage() {
        view.addSubview(movieImage)
        movieImage.translatesAutoresizingMaskIntoConstraints = false

        movieImage.contentMode = .scaleAspectFit

        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            movieImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: 250)
        ])
    }


    func configureMovieTitle() {
        view.addSubview(movieTitle)
        movieTitle.translatesAutoresizingMaskIntoConstraints = false

        movieTitle.font = UIFont.boldSystemFont(ofSize: 24)
        movieTitle.adjustsFontSizeToFitWidth = true
        movieTitle.minimumScaleFactor = 0.9

        NSLayoutConstraint.activate([
            movieTitle.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: topMargin),
            movieTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            movieTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: padding),
            movieTitle.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    func configureTrailerButton() {
        view.addSubview(trailerButton)
        trailerButton.translatesAutoresizingMaskIntoConstraints = false
    }

    func configureGenre() {
        view.addSubview(genresLabel)
        view.addSubview(genresContentLabel)
        genresLabel.translatesAutoresizingMaskIntoConstraints = false
        genresContentLabel.translatesAutoresizingMaskIntoConstraints = false

        genresLabel.text = "Genres"
        genresLabel.font = UIFont.boldSystemFont(ofSize: 20)

        genresContentLabel.adjustsFontSizeToFitWidth = true
        genresContentLabel.minimumScaleFactor = 0.9

        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 30),
            genresLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            genresLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genresLabel.heightAnchor.constraint(equalToConstant: 20),

            genresContentLabel.topAnchor.constraint(equalTo: genresLabel.bottomAnchor, constant: topMargin),
            genresContentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            genresContentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            genresContentLabel.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    func configureDate() {
        view.addSubview(dateTitleLabel)
        view.addSubview(date)
        dateTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        date.translatesAutoresizingMaskIntoConstraints = false

        dateTitleLabel.text = "Date"
        dateTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)

        NSLayoutConstraint.activate([
            dateTitleLabel.topAnchor.constraint(equalTo: genresContentLabel.bottomAnchor, constant: 30),
            dateTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateTitleLabel.heightAnchor.constraint(equalToConstant: 20),

            date.topAnchor.constraint(equalTo: dateTitleLabel.bottomAnchor, constant: topMargin),
            date.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            date.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            date.heightAnchor.constraint(equalToConstant: 20),
        ])
    }

    func configureOverview() {
        view.addSubview(overviewTitle)
        view.addSubview(overview)
        overviewTitle.translatesAutoresizingMaskIntoConstraints = false
        overview.translatesAutoresizingMaskIntoConstraints = false

        overviewTitle.text = "Overview"
        overviewTitle.font = UIFont.boldSystemFont(ofSize: 20)

        overview.numberOfLines = 0

        NSLayoutConstraint.activate([
            overviewTitle.topAnchor.constraint(equalTo: date.bottomAnchor, constant: 30),
            overviewTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overviewTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            overviewTitle.heightAnchor.constraint(equalToConstant: 20),

            overview.topAnchor.constraint(equalTo: overviewTitle.bottomAnchor, constant: topMargin),
            overview.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            overview.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding)
        ])
    }
}
