//
//  ResponseData.swift
//  GoogleMap
//
//  Created by developer on 10/10/20.
//  Copyright © 2020 WeFour. All rights reserved.
//

import Foundation
import CoreData

class ResponseData{
    private init() {}
    //MARK: getContext
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return ResponseData.persistentContainer.viewContext
    }

    //MARK: persistentContainer
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "GoogleMap")

        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }


        })
        return container
    }()

    // MARK: - Core Data Saving support
    class func saveContext() {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Data Saved to Context")
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    //MARK:- getAllDetails
    class func getAllDetails() -> Array<OrderDetails> {
        let all = NSFetchRequest<OrderDetails>(entityName: "OrderDetails")
        var allDetails = [OrderDetails]()
        let sortDescriptor = NSSortDescriptor(key: "customer_name", ascending: true)
        all.sortDescriptors = [sortDescriptor]

        do {
            let fetched = try ResponseData.getContext().fetch(all)
            allDetails = fetched
        } catch {
            let nserror = error as NSError
            //TODO: Handle Error
            print(nserror.description)
        }

        return allDetails
    }
    
}
