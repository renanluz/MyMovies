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
    
    // Variável que irá receber o trailer do filme
    var trailer: String = ""
  
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var lbDuration: UILabel!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbCategories: UILabel!
    @IBOutlet weak var tvSummary: UITextView!
    @IBOutlet weak var lbRating: UILabel!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        // Chamando o método loadTrailers passando o título do filme
        
        if let title = movie?.title {
            loadTrailers(title: title)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let movie = movie {
            ivMovie.image = movie.image as? UIImage
            lbTitle.text = movie.title
            lbCategories.text = movie.categories
            lbRating.text = "⭐️ \(movie.rating)/10"
            lbDuration.text = movie.duration
            tvSummary.text = movie.summary
        }
    }    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? AddEditViewController {
            vc.movie = movie
        }
    }
    
    
    func loadTrailers(title: String) {
       // Chamamos o método loadTrailers da classe API e na closure vamos recuperar o primeiro resultado da lista de resultados.
       API.loadTrailers(title: title) {(apiResult) in
        guard let results = apiResult?.results, let trailer = results.first else {return}
        
        
        // Aqui pegamso a url do trailer e atribuímos à nossa variável trailer, fazendo na thread main.
        DispatchQueue.main.async {
            self.trailer = trailer.previewUrl
            print("URL do Trailer:", trailer.previewUrl)
        }
        }
        
    }
    
}
