//
//  Utilities.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 14/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import CoreData
import UIKit

class CoreDataUtilities {

  static func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
  }  
  public static func storeEvent (event:EventContents) throws{
    let context = getContext()
    //retrieve the entity that we just created
    let entity =  NSEntityDescription.entity(forEntityName: "EventList", in: context)
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    //set the entity values
    transc.setValue(event.date, forKey: "date")
    transc.setValue(event.eventName, forKey: "EventName")
    transc.setValue(event.eventDescription, forKey: "EventDescription")
    transc.setValue(event.time, forKey:"time")
    //save the object
    do {
      try context.save()
    } catch let error as NSError  {
      throw error
    }
  }
  public static func getEvents() throws{
    //create a fetch request, telling it about the entity
    let fetchRequest: NSFetchRequest<EventList> = EventList.fetchRequest()
    do {
      //go get the results
      let searchResults = try getContext().fetch(fetchRequest)
      for _ in searchResults as [NSManagedObject] {
        //get the Key Value pairs (although there may be a better way to do that...
       
      }
    } catch {
      throw error
    }
  }
}
