//
//  DateView.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 07/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit
class DateView: UIView {
  
  var date:Date?
  var textOnView:String?
  var dateInfo:DateInfo = .thismonth
  var isDateHighlighted:Bool = false
  var isBeginningOfMonth:Bool = false
  var dateLabel:UILabel = UILabel()
  var dateUpdateDelegate:DateUpdateType?
  let myNotification = Notification.Name(rawValue:"ImGoingToBeHighlighted")
  
  convenience init(frame: CGRect, date:Date, dateValidity:DateInfo,dateupdateDelegate:DateUpdateType?) {
    self.init(frame: frame)
    self.backgroundColor = UIColor(white: 1.0, alpha: 0)
    self.date = date
    textOnView = String(Calendar.current.component(.day, from: date))
    dateInfo = dateValidity
    if dateInfo == .adjacentmonth {
      textOnView = ""
    }
    self.dateUpdateDelegate = dateupdateDelegate
    let nc = NotificationCenter.default
    nc.addObserver(forName:myNotification, object:nil, queue:nil, using:unHighlightWhenNotificationRecieved)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func isToday() -> Bool {
    let currentdate:Date = Date()
    if textOnView != "" && Calendar.current.compare(date!, to: currentdate, toGranularity: .day) == .orderedSame {
      return true
    }
    return false
  }
  public func getdateView(frame:CGRect) -> UILabel {
    dateLabel = UILabel(frame:frame)
    if isToday() {
     highlightDate()
    }
    else {
      unHighlightDate()
    }
    dateLabel.text = textOnView
    dateLabel.textColor = UIColor.gray
    dateLabel.textAlignment = .center
    dateLabel.font = UIUtilities.getFontforDevice()
    return dateLabel

  }
  override func draw(_ rect: CGRect) {
    let subview = getdateView(frame:rect)
    addSubview(subview)
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // add the highlight logic here
    super.touchesBegan(touches, with: event)
    if !isDateHighlighted {
      if textOnView != "" {
        // post the notification to unhighlight all the other cells if this cell has to be highlighted
        NotificationCenter.default.post(name: myNotification, object: nil)
        highlightDate()
        layoutSubviews()
      }
    }
  }
  
  private func highlightDate() {
    dateLabel.backgroundColor = UIColor.blue
    isDateHighlighted = true
    dateUpdateDelegate?.updatecurrentSelectedDate(date:self.date!)
  }
  private func unHighlightDate() {
    dateLabel.backgroundColor = UIColor.white
    isDateHighlighted = false
  }
  
  // notification catch method
  func unHighlightWhenNotificationRecieved(notification:Notification) {
    unHighlightDate()
  }
  
  
}
