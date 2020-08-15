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
    
    // Criando datepicker para recuperar a data
    var datePicker = UIDatePicker()
    
    // Criando o objeto de alerta
    var alert: UIAlertController!
    
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
        
        // Definindo a data mínima do datePicker para hoje
        datePicker.minimumDate = Date()
        
        // Adicionando o método a ser chamado quando o DatePicker tiver seu valor alterado
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
    }
    
    @objc func changeDate() {

        // Criamos o dateFormatter para formatar a data
        let dateformatter = DateFormatter()
        
        // Aqui, definimos o estilo que a data será apresentada
        dateformatter.dateFormat = "dd/MM/yyyy HH:mm'h"
        
        // Recuperamos a data do datePicker para repassar ao TextFied
        alert.textFields?.first?.text = dateformatter.string(from: datePicker.date)
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
    
    @IBAction func scheduleNotification(_ sender: UIButton) {
        // Criando o Alert Controller como .alert
        alert = UIAlertController(title: "Lembrete", message: "Quando deseja ser lembrado de assistir o filme?", preferredStyle: .alert)
        
        // Adicionando um Text Field ao alerta
        alert.addTextField {(textField) in
            textField.placeholder = "Data do Lembrete"
            self.datePicker.date = Date()
            textField.inputView = self.datePicker
                        
        }
        
        // Adicionando botões de Agendar e Cancelar. Para criar uma Action, definimos o seu título e seu estilo. O estilo .default é o padrão.
        
        let okAction = UIAlertAction(title: "Agendar", style: .default) {(action) in
            self.schedule()
        }
        
        // Em uma action que serve para cancelar uma ação, o ideal é utilizarmos o estilo .cancel
        let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        // Aqui adicionamos as duas actions ao alert
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        // Mostrando o alert para o usuário
        present(alert, animated: true, completion: nil)
    }
    
    func schedule(){
        print("Tá funcionando")
    }
    
    
}
