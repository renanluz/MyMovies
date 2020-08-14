//
//  AddEditViewController.swift
//  MyMovies
//
//  Created by Renan Luz on 11/08/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class AddEditViewController: UIViewController {
    
    // Variável que receberá o filme selecionado.
    var movie: Movie?
    
    @IBOutlet weak var ivMovie: UIImageView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfCategories: UITextField!
    @IBOutlet weak var tfDuration: UITextField!
    @IBOutlet weak var tfRating: UITextField!
    @IBOutlet weak var tfSummary: UITextView!
    @IBOutlet weak var btAddEdit: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie {
            ivMovie.image = movie.image as? UIImage
            tfTitle.text = movie.title
            tfCategories.text = movie.categories
            tfDuration.text = movie.duration
            tfRating.text = "\(movie.rating)"
            tfSummary.text = movie.summary
            btAddEdit.setTitle("Alterar", for: .normal)
        }
        

        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @available(iOS 13.0, *)
    @IBAction func addEditMovie(_ sender: UIButton) {
        // Se o movie for nulo é sinal que estamos criando um filme e portanto vamos instanciar um novo Movie.
        // Com a classe Core Data, instanciamos passando o context.
        if movie == nil {
            movie = Movie(context: context)
        }
        
        // Passamos para o movie os valores do campos
        movie?.title = tfTitle.text
        movie?.categories = tfCategories.text
        movie?.duration = tfDuration.text
        movie?.rating = Double(tfRating.text!) ?? 0
        movie?.image = ivMovie.image
        movie?.summary = tfSummary.text
        
        do {
            // O método abaixo salva qualquer alteração ocorrida no contexto, ou seja, altera o filme ou grava um novo
            try context.save()
            
            // O comando abaixo soliciata à Navigation Controller que retorne à tela anterior.
            navigationController?.popViewController(animated: true)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
