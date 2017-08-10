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
  var currentMonthView:UIView = UIView()
  var currentMonth:String = "January"
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    setupMonthHeader()
    setUpDataForCalendar()
    
  }
  init(frame:CGRect) {
    super.init(nibName:nil, bundle:Bundle.main)
    self.view.frame = frame
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  //This method will add the calendar view to the mainview.
  func setUpDataForCalendar() {
    monthView = MonthView.init(withframe:CGRect(x:self.view.frame.origin.x ,y:self.view.frame.origin.y + currentMonthView.frame.height,width:view.frame.size.width,height:view.frame.size.height/3))
    self.view.addSubview(monthView!.view)
  }
  
  // This method adds the header view for the calendar. Will add the monthname view, options to add events, etc.
  func setupMonthHeader() {
    currentMonthView.removeFromSuperview()
    currentMonthView = UIView(frame:CGRect(x:self.view.frame.origin.x ,y:self.view.frame.origin.y ,width:self.view.frame.size.width, height:self.view.frame.size.height * 0.09))
    let monthLabel = UILabel(frame:CGRect(x:currentMonthView.frame.origin.x + (currentMonthView.frame.size.width * 0.02),y:currentMonthView.frame.origin.y + (currentMonthView.frame.size.height * 0.02),width:(currentMonthView.frame.size.width * 0.4), height:currentMonthView.frame.size.height))
    monthLabel.text = getCurrentMonth()
    monthLabel.textAlignment = .center
    monthLabel.textColor = UIColor.blue
    let thelayer = UIUtilities.addLineLayer(fromPoint:CGPoint(x:0,y:currentMonthView.frame.height),toPoint:CGPoint(x:currentMonthView.frame.width,y:currentMonthView.frame.height), lineColor:UIColor.gray)
    self.currentMonthView.layer.addSublayer(thelayer)
    currentMonthView.addSubview(monthLabel)
    let button = UIButton(frame:CGRect(x:currentMonthView.frame.size.width - (currentMonthView.frame.size.width * 0.15), y:currentMonthView.frame.origin.y + (currentMonthView.frame.size.height * 0.30) ,width:(currentMonthView.frame.size.width * 0.08),height:currentMonthView.frame.size.height - (currentMonthView.frame.size.height * 0.5)))
    button.addTarget(self, action: #selector(MainViewController.loadAddEventsPage), for: UIControlEvents.touchUpInside)
    let btnImage = UIImage(named: "Add-icon.png")
    button.setImage(btnImage , for: UIControlState.normal)
    currentMonthView.addSubview(button)
    self.view.addSubview(currentMonthView)
    
  }
  
  //This method will return the current month being displayed in the calendar
  func getCurrentMonth() -> String {
    return currentMonth
  }
  
  // This method will perform the action of loading the eventsaddition page when we tap on add icon in the mainview
  func loadAddEventsPage() {
    //Add your code to load the AddEventsPage VC
  }

}

