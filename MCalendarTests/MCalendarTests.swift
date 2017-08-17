//
//  MCalendarTests.swift
//  MCalendarTests
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017. All rights reserved.
//

import XCTest
@testable import MCalendar

class MCalendarTests: XCTestCase {
  
  var getStartMonthInputs = [[String:Int]]()
  var getStartmonthOutputs = [Date]()
  var storeEventInput = [[String:AnyObject]]()
  var storeEventOutput = [Bool]()
  
    override func setUp() {
        super.setUp()
      let pathForInput = Bundle(for: MCalendarTests.self).path(forResource: "TestInputs", ofType: "plist") ?? ""
      let inputArray = (NSArray(contentsOfFile: pathForInput) ?? []) as! [Any] as [AnyObject]
      getStartMonthInputs = inputArray[0] as! [[String : Int]]
      let pathForOutput = Bundle(for: MCalendarTests.self).path(forResource: "TestOutputs", ofType: "plist") ?? ""
      let outputArray = NSArray(contentsOfFile: pathForOutput) ?? []
      getStartmonthOutputs = outputArray[0] as! [Date]
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testGetStartMonth() {
      // this testcase will fail, until we keep updating the output in plist to currentDate. Because, the method getstartdateformonth() returns current date incase of invalid inputs. Should pass if TestOutputs.plist file has currentdate at item[0][0] position.
      for (index,each) in getStartMonthInputs.enumerated() {
        let date = DateData.getStartDateForMonth(forMonth: each["month"]!, foryear: each["year"]!)
        if Calendar.current.compare(date, to: getStartmonthOutputs[index], toGranularity: .day) != .orderedSame {
          XCTAssert(false,"GetStartDate() did not give proper date")
        }
      }
    }
  func testStoreEvent() {
    for (index,each) in storeEventInput.enumerated() {
      let eventlist = EventContents(date: each["date"] as! Date, eventName: each["eventname"] as! String, eventDescription: each["eventdescription"] as! String, time: "11.20", place: each["place"] as! String)
      do {
         var result = false
         try CoreDataUtilities.storeEvent(event: eventlist, storeDataSucess: &result)
         if result == storeEventOutput[index] {
            XCTAssert(true, "Event info stored Properly")
         }
      }
      catch {
         XCTAssert(false,"StoreEvent() threw an exception")
      }
    }
  }
  
  func testgetEvents() {
    for each in storeEventInput {
      let eventlist = EventContents(date: each["date"] as! Date, eventName: each["eventname"] as! String, eventDescription: each["eventdescription"] as! String, time: "11.20", place: each["place"] as! String)
      do {
        let result = try CoreDataUtilities.getEvents(forDate: Date())
        if result.count == 1 && Calendar.current.compare(result[0].date! as Date, to:eventlist.date, toGranularity: .day) == .orderedSame && result[0].eventName! == eventlist.eventName && result[0].eventDescription! == eventlist.eventDescription && result[0].place! == eventlist.place {
          XCTAssert(true, "Event info stored Properly")
        }
      }
      catch {
        XCTAssert(false,"StoreEvent() threw an exception")
      }
    }
  }
  
  
}
