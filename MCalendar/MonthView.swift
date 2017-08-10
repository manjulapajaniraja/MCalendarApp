//
//  MonthView.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit

class MonthView: UITableViewController {
  
  var arrayOfWeeks:[[DateView]]
  let daysOfMonth = ["SU", "M", "T","W","TH","F","SA"]
  init(withframe frame: CGRect) {
     arrayOfWeeks = [[DateView]]()
     super.init(nibName: nil, bundle: nil)
     tableView.frame = frame
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
    return cell
  }
  override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let daysOfWeekView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.frame.size.width, height:self.tableView(tableView, heightForHeaderInSection: 0)))
    for i in 0..<7 {
      let dayOfWeek = UILabel(frame:CGRect(x:i*Int(self.tableView.frame.size.width/7),y:0,width:(Int(self.tableView.frame.size.width/7)),height:44))
      dayOfWeek.text = daysOfMonth[i]
      dayOfWeek.textAlignment = .center
      daysOfWeekView.addSubview(dayOfWeek)
      daysOfWeekView.bringSubview(toFront: dayOfWeek)
    }
    return daysOfWeekView
  }
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1;
  }
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return tableView.frame.size.height/6
  }
  override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    let height = 44
    return CGFloat(height)
  }
  
  // UITableView Delegate methods
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    //Your code here
  }
  
}
