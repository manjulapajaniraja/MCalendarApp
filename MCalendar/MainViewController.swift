//
//  ViewController.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
  
  var monthView: MonthView?

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    // Do any additional setup after loading the view, typically from a nib.
    setUpDataForCalendar()
  }
  
  

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func setUpDataForCalendar() {
    monthView = MonthView.init(withframe:CGRect(x:0,y:0,width:view.frame.size.width,height:view.frame.size.height/3))
    self.view.addSubview(monthView!.view)
  }


}

