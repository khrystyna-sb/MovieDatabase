//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Roma Test on 30.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var table: UITableView?
    let networkService = NetworkService()
    let searchController = UISearchController(searchResultsController: nil)
    var search: Search?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        table?.delegate = self
        table?.dataSource = self
        table?.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}


extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard  let url = URL(string: "https://movie-database-imdb-alternative.p.rapidapi.com/?s=\(searchText))&page=1&r=json") else { return }
        
        let request = networkService.request(url: url)
        networkService.dataTask(request: request as URLRequest, movieData: { (movieData) in
            guard let movieData = movieData else {return}
            self.search = movieData
            self.table?.reloadData()
        })
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.search = nil
        self.table?.reloadData()
    }
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        search?.search.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard  let table = table else { preconditionFailure("can't find table")}
        let cell = table.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let movieTitle = search?.search[indexPath.row]
        cell.textLabel?.text = movieTitle?.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did taped")
        guard  let table = table else { preconditionFailure("can't find table")}
        table.deselectRow(at: indexPath, animated: true)
        guard let movieInfoVC = (storyboard?.instantiateViewController(withIdentifier: "MovieInfoViewController")) as? MovieInfoViewController else {return}
        let movieData = search?.search[indexPath.row]
        movieInfoVC.movieTitle = movieData?.title
        movieInfoVC.movieType = movieData?.type
        movieInfoVC.movieYear = movieData?.year
        networkService.getImage(poster: movieData?.poster, complition: { image in
            movieInfoVC.moviePoster = image
        })
        navigationController?.pushViewController(movieInfoVC, animated: true)
    }
    
}
