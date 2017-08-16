//
//  EventsList.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit

class EventsView: UITableView, UITableViewDelegate, UITableViewDataSource {
  
  var eventsOnCurrentDate:[EventContents]?
  var currentDate = Date()
  
  init(frame: CGRect, style: UITableViewStyle, events:[EventContents], forDate:Date) {
    super.init(frame: frame, style: style)
    dataSource = self
    delegate = self
    self.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    eventsOnCurrentDate = events
    currentDate = forDate
    tableFooterView = UIView()
    allowsSelection = false
    separatorStyle = .none
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  //UITableView Datasource methods
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
    // Add the time of event
    let TimeOfEvent = UILabel(frame:CGRect(x:0,y:0,width:(Int(self.frame.size.width/3)),height:Int(self.tableView(self, heightForRowAt: indexPath))))
    TimeOfEvent.text = eventsOnCurrentDate?[indexPath.row].time
    TimeOfEvent.textAlignment = .center
    TimeOfEvent.textColor = UIColor.gray
    TimeOfEvent.backgroundColor = UIColor.white
    cell.contentView.addSubview(TimeOfEvent)
    // Add the event Name
    let eventName = UILabel(frame:CGRect(x:self.frame.size.width/3,y:0,width:(self.frame.size.width - TimeOfEvent.frame.width),height:self.tableView(self, heightForRowAt: indexPath)/2))
    eventName.text = eventsOnCurrentDate?[indexPath.row].eventName
    eventName.textAlignment = .left
    eventName.font = UIUtilities.getFontforDevice()
    eventName.textColor = UIColor.gray
    eventName.lineBreakMode = .byTruncatingTail
    eventName.backgroundColor = UIColor.white
    cell.contentView.addSubview(eventName)
    //Add event location
    let eventLocation = UILabel(frame:CGRect(x:self.frame.size.width/3,y:eventName.frame.height,width:(self.frame.size.width - TimeOfEvent.frame.width),height:self.tableView(self, heightForRowAt: indexPath)/2))
    let attachment = NSTextAttachment()
    attachment.image = UIImage(named: "LocationIcon.png")
    let attachmentString = NSAttributedString(attachment: attachment)
    let myString = NSMutableAttributedString()
    myString.append(attachmentString)
    myString.append(NSAttributedString(string:eventsOnCurrentDate?[indexPath.row].place ?? "", attributes:[NSFontAttributeName:UIUtilities.getFontforDevice(),NSForegroundColorAttributeName:UIColor.gray]))
    eventLocation.attributedText = myString
    eventLocation.textAlignment = .left
    eventLocation.textColor = UIColor.gray
    eventLocation.backgroundColor = UIColor.white
    cell.contentView.addSubview(eventLocation)
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventsOnCurrentDate?.count ?? 0
  }
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = CGFloat(Int(self.frame.height)/(eventsOnCurrentDate?.count ?? 1))
    // Assuming there would be 5 events at max in a day
    return height < self.frame.height/5 ? height:self.frame.height/5
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView()
    headerView.backgroundColor = UIColor.init(red: 107, green: 212, blue: 251, alpha: 1)
    return headerView
  }
  
  // UITableView Datasoruce methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // code here
  }
  
}
