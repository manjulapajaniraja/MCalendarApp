//
//  UIUtilities.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 10/08/17.
//  Copyright © 2017 sap. All rights reserved.
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
}
