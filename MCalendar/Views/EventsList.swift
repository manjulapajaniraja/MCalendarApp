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
  
  //UITableView Datasource methods
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell()
    return cell
  }
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return eventsOnCurrentDate?.count ?? 0
  }
  func numberOfSections(in tableView: UITableView) -> Int {
    return eventsOnCurrentDate?.count ?? 0
  }
  
  // UITableView Datasoruce methods
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // code here
  }
  
}
