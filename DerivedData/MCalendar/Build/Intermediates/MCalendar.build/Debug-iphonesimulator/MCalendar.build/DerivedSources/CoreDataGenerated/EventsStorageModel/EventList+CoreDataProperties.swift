//
//  EventList+CoreDataProperties.swift
//  
//
//  Created by Pajaniraja, Manjula on 15/08/17.
//
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension EventList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventList> {
        return NSFetchRequest<EventList>(entityName: "EventList")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var eventDescription: String?
    @NSManaged public var eventName: String?
    @NSManaged public var place: String?
    @NSManaged public var time: String?

}
