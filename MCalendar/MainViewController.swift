//
//  ViewController.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, DateUpdateType {
  
  var monthView: MonthView?
  var currentMonthView:UIView = UIView()
  var weekview:UIView = UIView()
  var currentMonth:String = "January"
  var currentYear:Int = 2017
  let daysOfMonth = ["SUN", "MON", "TUE","WED","THU","FRI","SAT"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    setupMonthHeader()
    setupWeekHeader()
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
    monthView = MonthView.init(withframe:CGRect(x:0 ,y:self.view.frame.origin.y + currentMonthView.frame.height + weekview.frame.height,width:view.frame.size.width,height:view.frame.size.height/3),currentMonth:8,currentYear:currentYear)
    monthView?.monthupdateDelegate = self
    monthView?.monthupdateDelegate?.updatecurrentMonthAndYear(month: monthView?.currentMonth ?? 1, year: monthView?.currentYear ?? 2017)
    self.view.addSubview(monthView!.view)
  }
  
  // This method adds the header view for the calendar. Will add the monthname view, options to add events, etc.
  func setupMonthHeader() {
    currentMonthView.removeFromSuperview()
    currentMonthView = UIView(frame:CGRect(x:self.view.frame.origin.x ,y:self.view.frame.origin.y ,width:self.view.frame.size.width, height:self.view.frame.size.height * 0.09))
    let monthLabel = UILabel(frame:CGRect(x:currentMonthView.frame.origin.x + (currentMonthView.frame.size.width * 0.02),y:currentMonthView.frame.origin.y + (currentMonthView.frame.size.height * 0.02),width:(currentMonthView.frame.size.width * 0.4), height:currentMonthView.frame.size.height))
    monthLabel.text = getCurrentMonth() + " " + String(currentYear)
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
  
  func setupWeekHeader() {
     weekview = UIView(frame: CGRect(x: 0, y: currentMonthView.frame.height, width: self.view.frame.size.width, height:self.view.frame.height * 0.08))
    weekview.backgroundColor = UIColor.white
    for i in 0..<7 {
      let dayOfWeek = UILabel(frame:CGRect(x:i*Int(self.view.frame.size.width/7),y:0,width:(Int(self.view.frame.size.width/7)),height:Int(self.view.frame.height * 0.08)))
      dayOfWeek.text = daysOfMonth[i]
      dayOfWeek.textAlignment = .center
      dayOfWeek.textColor = UIColor.gray
      dayOfWeek.backgroundColor = UIColor.white
      weekview.addSubview(dayOfWeek)
      weekview.bringSubview(toFront: dayOfWeek)
    }
     self.view.addSubview(weekview)
  }
  
  //This method will return the current month being displayed in the calendar
  func getCurrentMonth() -> String {
    return currentMonth
  }
  
  // This method will perform the action of loading the eventsaddition page when we tap on add icon in the mainview
  func loadAddEventsPage() {
    //Add your code to load the AddEventsPage VC
  }
  
  // Implementing the protocol methods here  
  func updatecurrentMonthAndYear(month:Int,year:Int) {
    self.currentYear = year
    self.currentMonth = DateData.getMonth(month: month)
    setupMonthHeader()
  }

}

