//
//  MovieInfoViewController.swift
//  MovieDatabase
//
//  Created by Roma Test on 21.07.2021.
//
import ViewAnimator
import UIKit

class MovieInfoViewController: UIViewController {

//    @IBOutlet weak var posterUIImageView: UIImageView?
    @IBOutlet weak var typeUILabel: UILabel?
    @IBOutlet weak var titleUILable: UILabel? 
    @IBOutlet weak var yearUILable: UILabel?
    let imageView = UIImageView(frame: CGRect(x: 60, y: 50, width: 280, height: 400))
    var movieTitle: String?
    var movieType: String?
    var movieYear: String?
 
    var moviePoster: UIImage? {
        didSet {
            self.imageView.image = moviePoster
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleUILable?.text = movieTitle
        self.typeUILabel?.text = movieType
        self.yearUILable?.text = movieYear
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        imageView.center = view.center
     //   imageView.constraints = CGRect(
        view.addSubview(imageView)
        imageView.animate(animations: [AnimationType.zoom(scale: 4)], duration: 2)
    }
}
