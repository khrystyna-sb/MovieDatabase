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
       
        
        
        
/*
        //---------------------------------------------
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
            request.httpMethod = "GET"
    
            let headers = [
                "x-rapidapi-key": "d8b060c0ecmshbf7bf4ee4577e6ap1c8459jsnd4216fa0e733",
                "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com"
            ]
        
            request.allHTTPHeaderFields = headers
        //--------------------------------------------------
        
            let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                DispatchQueue.main.async {
                    guard error == nil else { return }
                        
                        guard let data = data else {return}
                        do {
            //                let json2 = try JSONSerialization.jsonObject(with: data)
                            let json = try JSONDecoder().decode(Search.self, from: data)
                            self.search = json
                            self.table?.reloadData()
                            print(json)
                        } catch let error {
                            print("Failed to decode JSON: \(error.localizedDescription)")
                        }
                    }
            })
            dataTask.resume()
        //-------------------------------------------------
 */
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
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        
    }
    
}
