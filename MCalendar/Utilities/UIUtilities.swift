//
//  UIUtilities.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 10/08/17.
//  Copyright © 2017. All rights reserved.
//

import UIKit

public class UIUtilities {
  
  static func addLineLayer(fromPoint:CGPoint, toPoint:CGPoint, lineColor:UIColor) -> CAShapeLayer {
    let theLayer = CAShapeLayer()
    let path = UIBezierPath()
    path.move(to: fromPoint);
    path.addLine(to: toPoint);
    theLayer.path = path.cgPath
    theLayer.strokeColor = lineColor.cgColor
    theLayer.lineWidth = 0.5
    return theLayer
  }
  
  //Get the fontsize based on device.
  static func getFontforDevice() -> UIFont {
    if UIDevice.current.name.hasPrefix("iPad") {
      return UIFont.init(name: "HelveticaNeue", size: 16)!
    }
    else {
      return UIFont.init(name: "HelveticaNeue", size: 14)!
    }
  }
}
