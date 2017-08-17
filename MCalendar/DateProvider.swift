//
//  DateProvider.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 13/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import Foundation

public class DateData {
  
  //This method will return the array of dates for the specified month
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
           date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
           date = calendar.date(byAdding: .day, value: 1, to: date)!
           if weekday == 7 {
             break
          }
        }
      }
    }
    return monthDates
  }
  //This method calculates and returns the start date for the month by setting hour and min components to 0.
  public static func getStartDateForMonth(forMonth month:Int, foryear year:Int) -> Date {
    if month > 0 && month <= 12 {
      var dateComponents = DateComponents()
      dateComponents.year = year
      dateComponents.month = month
      dateComponents.day = 1
      dateComponents.timeZone = TimeZone(abbreviation: "GMT+0:00")
      dateComponents.hour = 8
      dateComponents.minute = 34
      //calculate date using the dateComponents
      var startDate = Calendar.current.date(from: dateComponents)
      startDate = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: startDate!)
      return startDate!
    }
    return Date()
    
  }
  
  //This method returns the string equivalent of the month.
  public static func getMonth(month:Int) -> String {
    switch month {
    case 1:
      return "January"
    case 2:
      return "February"
    case 3:
      return "March"
    case 4:
      return "April"
    case 5:
      return "May"
    case 6:
      return "June"
    case 7:
      return "July"
    case 8:
      return "August"
    case 9:
      return "September"
    case 10:
      return "October"
    case 11:
      return "November"
    default:
      return "December"
    }
  }
  
  //This method returns the string equivalent of the weekday.
  public static func getDayName(day:Int) -> String {
    switch day {
    case 1:
      return "Sunday"
    case 2:
      return "Monday"
    case 3:
      return "Tuesday"
    case 4:
      return "Wednesday"
    case 5:
      return "Thursday"
    case 6:
      return "Friday"
    default:
      return "Saturday"
    }
  }
  // This method checks n returns true if the input date is today, if not false.
  public static func isToday(date:Date) -> Bool {
    let currentdate:Date = Date()
    if Calendar.current.compare(date, to: currentdate, toGranularity: .day) == .orderedSame {
      return true
    }
    return false
  }
}
