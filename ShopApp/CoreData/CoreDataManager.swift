//
//  CoreDataManager.swift
//  ShopApp
//
//  Created by Zhansaya on 15.06.2021.
//

import Foundation
import CoreData

class CoreDataManager{
    
    public static let shared = CoreDataManager()
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LocalDBModel")
        container.loadPersistentStores(completionHandler: {(storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init() {}
    
    func save() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    func addUser(_ email: String, id: Int) {
        let context = persistentContainer.viewContext
        
        context.perform {
            let newUser = UserEntity(context: context)
            newUser.id = Int64(id)
            newUser.email = email
        }
        save()
    }
    
    
    func findUser(with id: Int) -> UserEntity?{
        let context = persistentContainer.viewContext
        let requestResult: NSFetchRequest<UserEntity>  = UserEntity.fetchRequest()
        requestResult.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let users = try context.fetch(requestResult)
            if users.count > 0 {
                //assert(users.count == 1, "Duplicate found in DB!")
                return users[0]
            }
        }catch {
            print(error)
        }
        return nil
    }
    
    func deleteUser(with id: Int) {
        let context = persistentContainer.viewContext
        if let user = findUser(with: id) {
            context.delete(user)
        }
        save()
    }

}
