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
  
  convenience init(frame: CGRect, date:Date, dateValidity:DateInfo) {
    self.init(frame: frame)
    self.backgroundColor = UIColor(white: 1.0, alpha: 0)
    self.date = date
    textOnView = String(Calendar.current.component(.day, from: date))
    dateInfo = dateValidity
    if dateInfo == .adjacentmonth {
      textOnView = ""
    }
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  private func isToday() -> Bool {
    let currentdate:Date = Date()
    if currentdate == self.date {
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
    dateLabel.font = UIFont(name: "Helvatica-Nue", size: 12)
    return dateLabel

  }
  override func draw(_ rect: CGRect) {
    let subview = getdateView(frame:rect)
    addSubview(subview)
  }
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    // add the highlight logic here
    super.touchesBegan(touches, with: event)
    if textOnView != "" {
      highlightDate()
      layoutSubviews()
    }
  }
  
  private func highlightDate() {
    dateLabel.backgroundColor = UIColor.blue
    isDateHighlighted = true
  }
  private func unHighlightDate() {
    dateLabel.backgroundColor = UIColor.white
    isDateHighlighted = false
  }
}
