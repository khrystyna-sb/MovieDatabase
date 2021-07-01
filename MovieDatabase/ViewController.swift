//
//  ViewController.swift
//  MovieDatabase
//
//  Created by Roma Test on 30.06.2021.
//

import UIKit

class ViewController: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        guard  let url = URL(string: "https://movie-database-imdb-alternative.p.rapidapi.com/?s=\(searchText))&page=1&r=json") else { return }
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
            request.httpMethod = "GET"
    
            let headers = [
                "x-rapidapi-key": "d8b060c0ecmshbf7bf4ee4577e6ap1c8459jsnd4216fa0e733",
                "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com"
            ]
            request.allHTTPHeaderFields = headers
            
            URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                guard error == nil else { return }
                    
                    guard let data = data else {return}
                    do {
        //                let json2 = try JSONSerialization.jsonObject(with: data)
                        let json = try JSONDecoder().decode(Search.self, from: data)
                        print(json)
                    } catch let error {
                        print("Failed to decode JSON: \(error.localizedDescription)")
                    }
            }).resume()
    }
}


