//
//  OrderDetailsViewModel.swift
//  GoogleMap
//
//  Created by developer on 10/10/20.
//  Copyright © 2020 WeFour. All rights reserved.
//

import Foundation
import CoreData

class OrderDetailsViewModel{
    
      //Original Array from Core Data
      var orderArray = [OrderDetails]()
      //New Values to Core Data
    var getInfo:Json4Swift_Base.Order? {
          didSet {
              // Add the new spots to Core Data Context
            self.addDetailsToCoreData([self.getInfo!])
              // Save them to Core Data
              ResponseData.saveContext()
              //MyOrder
              self.orderArray = ResponseData.getAllDetails()
          }
      }
      
      //MARK:- addDetailsToCoreData
      func addDetailsToCoreData(_ order: [Json4Swift_Base.Order]) {
          for value in order {
              let entity = NSEntityDescription.entity(forEntityName: "OrderDetails", in: ResponseData.getContext())
              let newDetails = NSManagedObject(entity: entity!, insertInto: ResponseData.getContext())
              // Set the data to the entity
              newDetails.setValue(value.customer_name, forKey: "customer_name")
              newDetails.setValue(value.customer_mobile, forKey: "customer_mobile")
              newDetails.setValue(value.customer_lat, forKey: "customer_lat")
              newDetails.setValue(value.customer_lng, forKey: "customer_lng")
              newDetails.setValue(value.warehouse_lat, forKey: "warehouse_lat")
              newDetails.setValue(value.warehouse_lng, forKey: "warehouse_lng")
              newDetails.setValue(value.warehouse_address, forKey: "warehouse_address")
              newDetails.setValue(value.customer_address, forKey: "customer_address")

          }
      }
      
      //MARK:- readJsonFile
      func readJsonFile() {
          if let path = Bundle.main.path(forResource: "TestResponse", ofType: "json") {
              do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  do {
                      let decoder = JSONDecoder()
                      let getData = try decoder.decode(Json4Swift_Base.self, from: data)
                      self.getInfo = getData.order
                    
                  } catch {
                      print(error)
                  }
              } catch {
                  // handle error
              }
          }
      }
}
