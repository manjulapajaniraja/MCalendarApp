//
//  Utilities.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 14/08/17.
//  Copyright © 2017. All rights reserved.
//

import CoreData
import UIKit

class CoreDataUtilities {

  // to get the managedObject Context
  static func getContext () -> NSManagedObjectContext {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    return appDelegate.persistentContainer.viewContext
  }
  //To insert data into CoreData
  public static func storeEvent (event:EventContents, storeDataSucess:inout Bool) throws{
    let context = getContext()
    //retrieve the entity that we just created
    let entity =  NSEntityDescription.entity(forEntityName: "EventList", in: context)
    let transc = NSManagedObject(entity: entity!, insertInto: context)
    //set the entity values
    transc.setValue(event.date, forKey: "date")
    transc.setValue(event.eventName, forKey: "EventName")
    transc.setValue(event.eventDescription, forKey: "EventDescription")
    transc.setValue(event.time, forKey:"time")
    transc.setValue(event.place, forKey: "place")
    //save the object
    do {
      try context.save()
      storeDataSucess = true
    } catch let error as NSError  {
      storeDataSucess = false
      // Throw the error in case of any exception
      throw error
    }
  }
  // To retrieve information from coredata
  public static func getEvents(forDate:Date) throws -> [EventList]{
    //create a fetch request, telling it about the entity
    let startOfDay = Calendar.current.date(bySettingHour: 0, minute: 0, second: 1, of: forDate)
    let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: forDate)
    let fetchRequest: NSFetchRequest<EventList> = EventList.fetchRequest()
    fetchRequest.predicate = NSPredicate(format:  "(date >= %@) AND (date <= %@)",startOfDay! as CVarArg,endOfDay! as CVarArg)
    do {
      //go get the results
      let searchResults = try getContext().fetch(fetchRequest)
      return searchResults
    } catch {
      // Throw the error in case of any exception
      throw error
    }
  }
}
