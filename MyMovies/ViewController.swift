//
//  ViewController.swift
//  MyMovies
//
//  Created by Renan Luz on 10/08/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var movie: Movie?
  
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var lbRating: UILabel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        if let movie = movie {
            ivMovie.image = UIImage(named: movie.image)
            lbTitle.text = movie.title
            lbCategories.text = movie.categories
            lbRating.text = "⭐️ \(movie.rating)/10"
            lbDuration.text = movie.duration
            tvSummary.text = movie.summary
        }
    }

}

