//
//  SettingsViewController.swift
//  MyMovies
//
//  Created by Renan Luz on 11/08/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var swPlay: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Aqui estamos pedindo ao UserDefaults nos fornecer o booleano vinculado à chave play.
        // Caso não exista o valor será false.
        swPlay.isOn = UserDefaults.standard.bool(forKey: "play")
    }
    
    @IBAction func changePlay(_ sender: UISwitch) {
        // Sempre que o usuário tocar no switch, o seu estado (isOn é a propriedade que indica se o switch está ligado ou não) será atribuido à chave play dentro do UserDefaults.
        UserDefaults.standard.set(sender.isOn, forKey: "play")
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
