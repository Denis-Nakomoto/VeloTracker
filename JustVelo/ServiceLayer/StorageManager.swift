//
//  StorageManager.swift
//  JustVelo
//
//  Created by Denis Svetlakov on 29.09.2021.
//

import CoreData
import UIKit

class StorageManager {
    
    static let shared = StorageManager()
    
    private init() {}
    
    var trainings = Observer(value: [])
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Training> = Training.fetchRequest()
        fetchRequest.returnsObjectsAsFaults = false
        do {
            let fetchedTrainings = try context.fetch(fetchRequest)
            self.trainings.value = fetchedTrainings
        } catch let error {
            print("Failed to fetch data", error)
        }
    }
    
    func addNewTraining(date: Date, pathPassed: Data?, distance: String, time: String, completion: (Training) -> Void) {
        guard let entityDescription = NSEntityDescription.entity(forEntityName: "Training", in: context) else { return }
        let newTraining = NSManagedObject(entity: entityDescription, insertInto: context) as! Training
        newTraining.distance = distance
        newTraining.date = date
        newTraining.pathPassed = pathPassed
        newTraining.time = time
//        newTraining.calories = training.calories
        completion(newTraining)
        
        do {
            try context.save()
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        self.fetchData()
    }
    
    func deleteTraining(item: Training) {

        context.delete(item)
        
        do {
           try context.save()
        }
        catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        self.fetchData()
    }
    
    
}
