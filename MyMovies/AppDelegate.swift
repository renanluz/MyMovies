//
//  AppDelegate.swift
//  MyMovies
//
//  Created by Renan Luz on 10/08/20.
//  Copyright © 2020 FIAP. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@available(iOS 13.0, *)
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Definimos o delegate do UNUserNotificationCenter como sendo esta própria classe.
        //Com isso, esta classe irá responder pelo UNUserNotificationCenter.
        UNUserNotificationCenter.current().delegate = self
        
        //Primeiro solicitamos que seja fornecido o ajuste atual, ou seja, o que o usuário respondeu quando foi solicitada a permissão.
        UNUserNotificationCenter.current().getNotificationSettings {(settings) in
            
            //Se o status de autorização for notDetermined, significa que o usuário nunca foi pedido para aceitar ou seja, é a primeira vez que o app é aberto.
            //Nesse caso, iremos solicitar a permissão.
            if settings.authorizationStatus == .notDetermined {
                
                //Primeiro cria-se um arquivo de opções indicando o que nossa notificação irá fazer.
                //No nosso caso, iremos mostar um alerta da notificação e tocar um som.
                let options: UNAuthorizationOptions = [.alert, .sound]
                
                //Aqui, através do método requstAuthorization, solicitamos a autorização
                UNUserNotificationCenter.current().requestAuthorization(options: options, completionHandler: {(success, error) in
                    
                    // A propriedade success indica se o usuário autorizou ou não.
                    
                    if error == nil {
                        print(success)
                    } else {
                        print(error!.localizedDescription)
                    }
                })
                //Caso o usuário tenha negado, sempre imprimimos a mensagem abaixo.
                } else if settings.authorizationStatus == .denied {
                    print("Usuário negou a Notificação")
                }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MyMovies")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

@available(iOS 13.0, *)
extension AppDelegate: UNUserNotificationCenterDelegate {
    
    //Método chamado quando a notificação for aparecer com o app aberto
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    //Método chamado quando a notificação for aparecer com o app fechado ou em background
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        completionHandler()
    }
}

