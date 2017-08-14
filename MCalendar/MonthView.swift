//
//  MonthView.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit

class MonthView: UITableViewController {
  
  var arrayOfWeeks = [[DateView]]()
  var currentMonth : Int = 1
  var currentYear : Int = 2017
  var monthupdateDelegate:DateUpdateType?
  
  init(withframe frame: CGRect, currentMonth:Int, currentYear:Int) {
     super.init(nibName: nil, bundle: nil)
     tableView = UITableView(frame: frame, style: .plain)
     tableView.allowsSelection = false
     self.currentMonth = currentMonth
     self.currentYear = currentYear
     initializeDateViewArrayFor(month: currentMonth, year: currentYear)
  }
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
     tableView.delegate = self
     tableView.dataSource = self
     tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
  }
  
  //UITableView Datasource methods
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    for i in 0..<7 {
      if arrayOfWeeks.count > indexPath.row{
        let dateview = arrayOfWeeks[indexPath.row][i]
          dateview.frame = CGRect(x:i*Int(self.tableView.frame.size.width/7),y:0,width:(Int(self.tableView.frame.size.width/7)),height:Int(tableView.frame.size.height/5))
        cell.contentView.addSubview(dateview)
      }
    }
    return cell
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.size.height/5
  }
  // UITableView Delegate methods
  
  
  //Objects initialization for displaying dates are done here
  private func initializeDateViewArrayFor(month:Int, year:Int) {
    let datedatas = DateData.getdays(forMonth: month, year: year)
    let frame = CGRect(x: 0, y: 0, width: self.tableView.frame.size.width/7, height:self.tableView(tableView, heightForHeaderInSection: 0))
    let formatter = DateFormatter()
    formatter.dateFormat = "dd/MM/yyyy"
    arrayOfWeeks = [[DateView]]()
    for i in 0..<5 {
      var arrayOfDays = [DateView]()
      for j in 0..<7 {
        if datedatas[i][j] != "" {
          let dateView = DateView(frame: frame, date: formatter.date(from: datedatas[i][j])!,dateValidity:.thismonth)
          arrayOfDays.append(dateView)
        }
        else {
          let dateView = DateView(frame: frame, date:Date(), dateValidity:.adjacentmonth)
          arrayOfDays.append(dateView)
        }
      }
      arrayOfWeeks.append(arrayOfDays)
    }
  }
  
  override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let currentOffset = scrollView.contentOffset.y
    let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
    let deltaOffset = maximumOffset - currentOffset
    if deltaOffset < 0  && deltaOffset > -tableView.frame.height/2 {
      // load next month data
      loadAdjacentMonthDates(adjacentComponent: 1)
      
    }
    if deltaOffset > 0 && deltaOffset > tableView.frame.height/2 {
      //load prev month data
      loadAdjacentMonthDates(adjacentComponent: -1)

    }
  }
  
  private func loadAdjacentMonthDates(adjacentComponent:Int) {
    var currentmonthstart = DateData.getStartDateForMonth(forMonth:currentMonth,foryear:currentYear)
    var components = DateComponents()
    components.setValue(1, for: .month)
    currentmonthstart = Calendar.current.date(byAdding: .month, value: adjacentComponent, to: currentmonthstart)!
    components = Calendar.current.dateComponents([.day,.month,.year], from:currentmonthstart)
    currentMonth = components.month!
    currentYear = components.year!
    initializeDateViewArrayFor(month: currentMonth, year: currentYear)
    tableView.reloadData()
    monthupdateDelegate?.updatecurrentMonthAndYear(month: currentMonth, year: currentYear)
  }
  
}
