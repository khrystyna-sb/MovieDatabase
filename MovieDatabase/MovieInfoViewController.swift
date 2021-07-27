//
//  MovieInfoViewController.swift
//  MovieDatabase
//
//  Created by Roma Test on 21.07.2021.
//

import UIKit

class MovieInfoViewController: UIViewController {

    @IBOutlet weak var posterUIImageView: UIImageView?
    @IBOutlet weak var typeUILabel: UILabel?
    @IBOutlet weak var titleUILable: UILabel? 
    @IBOutlet weak var yearUILable: UILabel?
    var movieTitle: String?
    var movieType: String?
    var movieYear: String?
    
    var moviePoster: UIImage? {
        didSet {
            self.posterUIImageView?.image = moviePoster
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleUILable?.text = movieTitle
        self.typeUILabel?.text = movieType
        self.yearUILable?.text = movieYear
    }
    

  

}
