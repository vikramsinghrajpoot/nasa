//
//  CoreDataManager.swift
//  Nasa
//
//  Created by vikram on 1/08/22.
//

import Foundation
import UIKit
import CoreData

final class CoreDataManager {
    let entityName = "NASAEntity"
    static let shared = CoreDataManager()
    private init(){}
    
    func saveFavorite(data: POD, completion: @escaping (Bool) -> Void) {
        
        //As we know that container is set up in the AppDelegates so we need to refer that container.
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        
        //We need to create a context from this container
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //Now let’s create an entity and new user records.
        let userEntity = NSEntityDescription.entity(forEntityName: entityName, in: managedContext)!
        
        //final, we need to add some data to our newly created record for each keys using
        //here adding 5 data with loop
        
        let user = NSManagedObject(entity: userEntity, insertInto: managedContext)
        user.setValue(data.date, forKeyPath: "date")
        user.setValue(data.title, forKey: "title")
        user.setValue(data.explanation, forKey: "explanation")
        user.setValue(data.url, forKey: "url")
        
        do {
            try managedContext.save()
            completion(true)
        } catch let error as NSError {
            completion(false)
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func retrieveData(completion: @escaping ([POD]) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion([])
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            let result = try managedContext.fetch(fetchRequest)
            var podList = [POD]()
            for data in result as! [NSManagedObject] {
                var date = ""
                var explanation = ""
                var mediaType = ""
                var title = ""
                var mediaData: String?
                
                if let dateS = data.value(forKey: "date") as? String {
                    date = dateS
                }
                if let explanationS = data.value(forKey: "explanation") as? String {
                    explanation = explanationS
                }
                if let mediaTypeS = data.value(forKey: "media_type") as? String {
                    mediaType = mediaTypeS
                }
                if let titleS = data.value(forKey: "title") as? String {
                    title = titleS
                }
                if let mediaD = data.value(forKey: "url") as? String {
                    mediaData = mediaD
                }
                
                podList.append(POD(date: date, explanation: explanation, mediaType: mediaType, title: title, url: nil, mediaData: mediaData, isLocalData: true))
            }
            completion(podList)
        } catch {
            print("Failed")
            completion([])
        }
    }
    
    func isFavorite(date: String, completion: @escaping (Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            completion(false)
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        do {
            let result = try managedContext.fetch(fetchRequest)
            if result.count > 0 {
                completion(true)
            } else {
                completion(false)
            }
        } catch {
            print("Failed")
            completion(false)
        }
    }
    
    func removeFavorite(date: String, completion: @escaping (Bool) -> Void) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "date = %@", date)
        do {
            let test = try managedContext.fetch(fetchRequest)
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            do{
                try managedContext.save()
                completion(true)
            } catch {
                print(error)
                completion(false)
            }
        } catch {
            print(error)
            completion(false)
        }
    }
}
