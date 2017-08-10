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
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    self.frame = frame
    self.backgroundColor = UIColor(white: 1.0, alpha: 0)
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
    let label = UILabel(frame:frame)
    if isToday() {
      label.backgroundColor = UIColor.blue
    }
    else {
      label.backgroundColor = UIColor.white
    }
    label.text = textOnView
    label.textColor = UIColor.gray
    label.textAlignment = .center
    label.font = UIFont(name: "Helvatica-Nue", size: 12)
    return label

  }
  
}
