//
//  UIViewController+CoreData.swift
//  MyMovies
//
//  Created by Renan Luz on 11/08/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit
import CoreData

extension UIViewController {
    
    // Esta variável computada nos dará acesso ao NSManagedObjectContext a partir de qualquer tela
    @available(iOS 13.0, *)
    var context: NSManagedObjectContext {
        
        //Aqui estamos criando uma referência ao AppDelegate
        let appDelegate = UIApplication.shared.delegate
             as! AppDelegate
        

        // Conseguimos acessar o NSManagedObjectContext a partir da propriedade .viewContext presente em nosso persistentContainer.
        // Aqui apenas retornamos essa propriedade.
        return appDelegate.persistentContainer.viewContext
    }
}
