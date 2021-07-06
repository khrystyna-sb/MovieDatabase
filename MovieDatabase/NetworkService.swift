//
//  NetworkService.swift
//  MovieDatabase
//
//  Created by Roma Test on 05.07.2021.
//

import Foundation

protocol NetworkServiceProtocol {
    
    
    func request(url: URL) -> NSMutableURLRequest
    func dataTask(request: URLRequest, movieData: @escaping (Search?) -> Void)
    
}

class NetworkService: NetworkServiceProtocol {
    
    func request(url: URL) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        
            request.httpMethod = "GET"
    
            let headers = [
                "x-rapidapi-key": "d8b060c0ecmshbf7bf4ee4577e6ap1c8459jsnd4216fa0e733",
                "x-rapidapi-host": "movie-database-imdb-alternative.p.rapidapi.com"
            ]
        
            request.allHTTPHeaderFields = headers
        
           return request
    }
    
    func dataTask(request: URLRequest, movieData: @escaping (Search?) -> Void) {
        
        URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                    DispatchQueue.main.async {
                        guard error == nil else { return }
        
                            guard let data = data else {return}
                            do {
                //                let json2 = try JSONSerialization.jsonObject(with: data)
                                let json = try JSONDecoder().decode(Search.self, from: data)
                                movieData(json)
                                print(json)
                            } catch let error {
                                print("Failed to decode JSON: \(error.localizedDescription)")
                                movieData(nil)
                            }
                        }
                }).resume()
    }
}
