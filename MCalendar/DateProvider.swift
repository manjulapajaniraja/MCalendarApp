//
//  DateProvider.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 13/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import Foundation

public class DateData {
  
  public static func getdays(forMonth month:Int, year:Int) -> [[String]]{
    let calendar = Calendar.current
    // Calculate start and end of the current year (or month with `.month`):
    var date = getStartDateForMonth(forMonth: month, foryear: year)
    let interval = calendar.dateInterval(of: .month, for: date)
    // Compute difference in days:
    let days = calendar.dateComponents([.day], from: (interval?.start)!, to: (interval?.end)!).day!
    var monthDates = [[String]]()
    //init monthDates 
    for _ in 0..<5 {
      var weekArray = [String]()
      for _ in 0..<7 {
        weekArray.append("")
      }
      monthDates.append(weekArray)
    }
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    for i in 0..<5 {
      for _ in 0..<7 {
        if Calendar.current.component(.day, from: date)  <= days  {
           let weekday = calendar.component(.weekday, from: date)
           monthDates[i][weekday-1] = formatter.string(from:date)
           var components = DateComponents()
           components.setValue(1, for: .day)
           if Calendar.current.component(.day, from: date)  == days {
             break
           }
           date = calendar.date(byAdding: .day, value: 1, to: date)!
           if weekday == 7 {
             break
          }
        }
      }
    }
    return monthDates
  }
  
  public static func getStartDateForMonth(forMonth month:Int, foryear year:Int) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = year
    dateComponents.month = month
    dateComponents.day = 1
    dateComponents.timeZone = TimeZone(abbreviation: "GST")
    dateComponents.hour = 8
    dateComponents.minute = 34
    //calculate date using the dateComponents
    let startDate = Calendar.current.date(from: dateComponents)
    return startDate!
  }
}
