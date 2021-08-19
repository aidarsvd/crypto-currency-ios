//
//  PersistneceController.swift
//  crypto-info
//
//  Created by Айдар Чакиев on 19/8/21.
//

import Foundation
import CoreData

class PersistneceController {
    static let shared = PersistneceController()
    let container: NSPersistentContainer
    
    @Published var coins: [Coin] = []
    
    init() {
        container = NSPersistentContainer(name: "CryptoCoin")
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError?{
                fatalError("Error: \(error)")
            }
        }
    }
    
    private func save(completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(error)
            }
        }
    }

    func getAllData(){
        let fetchRequest: NSFetchRequest<Coin> = Coin.fetchRequest()
        do{
            coins = try container.viewContext.fetch(fetchRequest)
        }catch{
            print("Error")
        }
    }
    
    func addCoin(object: Crypto){
        let entityToSave = Coin(context: container.viewContext)
        entityToSave.id = object.id
        entityToSave.image = object.image
        entityToSave.name = object.name
        entityToSave.price_change_percentage_24h = object.price_change_percentage_24h
        entityToSave.current_price = object.current_price
        entityToSave.market_cap_rank = Int64(object.market_cap_rank)
        save()
    }
    
    func deleteAllData(){
        let fetchRequest: NSFetchRequest<Coin> = Coin.fetchRequest()
        do{
            let objects = try container.viewContext.fetch(fetchRequest)
            for obj in objects {
                PersistneceController.shared.deleteCoin(obj)
            }
        }catch{
            print("Error")
        }
    }
    
    func deleteCoin(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
        let context = container.viewContext
        context.delete(object)
        save(completion: completion)
    }

}
