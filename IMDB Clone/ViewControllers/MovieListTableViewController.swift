//
//  MovieListTableViewController.swift
//  IMDB Clone
//
//  Created by Karim Cordilia on 19/01/2020.
//  Copyright © 2020 Karim Cordilia. All rights reserved.
//

import UIKit
import Kingfisher

class MovieListTableViewController: UIViewController {

    var tableView: UITableView!

    var listOfMovies: [Movie] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getMovies()
        title = "Popular Movies"
    }

    func configureTableView() {
        tableView = UITableView(frame: view.bounds)
        view.addSubview(tableView)
        tableView.rowHeight = 150
        tableView.register(MovieCell.self, forCellReuseIdentifier: MovieCell.reuseId)
        tableView.delegate = self
        tableView.dataSource = self
    }

    func getMovies() {
        showLoadingView()
        NetworkManager.shared.getMovies { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()

            switch result {

            case .success(let movies):
                self.listOfMovies.append(contentsOf: movies)
                self.updateData()

            case .failure(let error):
                print(error.localizedDescription)
            }

        }
    }

    func updateData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

extension MovieListTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MovieCell
        UIView.animate(withDuration: 0.1, animations: {
            cell.alpha = 0.5
            cell.movieImage.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) { (completed) in
            UIView.animate(withDuration: 0.1) {
                cell.alpha = 1
                cell.movieImage.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
            let detailViewController = MovieDetailViewController()
            detailViewController.movieID = self.listOfMovies[indexPath.row].id
            self.navigationController?.pushViewController(detailViewController, animated: true)
        }


    }
}

extension MovieListTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfMovies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseId) as! MovieCell
        let movie = listOfMovies[indexPath.row]
        cell.set(movie: movie)
        return cell
    }


}


