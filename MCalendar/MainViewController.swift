//
//  ViewController.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit
import CoreLocation

class MainViewController: UIViewController, DateUpdateType,CLLocationManagerDelegate {
  
  var monthView: MonthView?
  var currentMonthView:UIView = UIView()
  var weekview:UIView = UIView()
  var currentSelectedDate = Date()
  let daysOfMonth = ["SU", "MO", "TU","WE","TH","FR","SA"]
  var eventsView:EventsView?
  let locationManager = CLLocationManager()
  var temperatureView = UILabel()
  var currentTemp:Double = 109.5 {
    didSet {
      setTemperatureView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor.white
    setupMonthHeader()
    setupWeekHeader()
    setUpDataForCalendar()
    setupEventsList(forCurrentDate:currentSelectedDate)
    // Ask for Authorisation from the User.
    self.locationManager.requestAlwaysAuthorization()
    self.locationManager.distanceFilter = 20.0
    // For use in foreground
    self.locationManager.requestWhenInUseAuthorization()
    if CLLocationManager.locationServicesEnabled() {
      locationManager.delegate = self
      locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
      locationManager.startUpdatingLocation()
    }
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
    monthView = MonthView.init(withframe:CGRect(x:0 ,y:self.view.frame.origin.y + currentMonthView.frame.height + weekview.frame.height,width:view.frame.size.width,height:view.frame.size.height/3),currentMonth:getCurrentMonth(),currentYear:getCurrentYear())
    monthView?.monthupdateDelegate = self
    monthView?.monthupdateDelegate?.updatecurrentSelectedDate(date: Date())
    self.view.addSubview(monthView!.view)
  }
  
  // This method adds the header view for the calendar. Will add the monthname view, options to add events, etc.
  func setupMonthHeader() {
    currentMonthView.removeFromSuperview()
    currentMonthView = UIView(frame:CGRect(x:self.view.frame.origin.x ,y:self.view.frame.origin.y ,width:self.view.frame.size.width, height:self.view.frame.size.height * 0.09))
    let monthLabel = UILabel(frame:CGRect(x:currentMonthView.frame.origin.x + (currentMonthView.frame.size.width * 0.02),y:currentMonthView.frame.origin.y + (currentMonthView.frame.size.height * 0.02),width:(currentMonthView.frame.size.width * 0.3), height:currentMonthView.frame.size.height))
    monthLabel.text = DateData.getMonth(month: getCurrentMonth()) + " " + String(getCurrentYear())
    monthLabel.textAlignment = .center
    monthLabel.textColor =  UIColor(red: 107/255, green: 202/255, blue: 251/255, alpha: 1)
      //UIColor.init(red: 107, green: 212, blue: 251, alpha: 0)
    monthLabel.font = UIUtilities.getFontforDevice()
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
  // This method will set the header for the week
  func setupWeekHeader() {
     weekview = UIView(frame: CGRect(x: 0, y: currentMonthView.frame.height, width: self.view.frame.size.width, height:self.view.frame.height * 0.08))
    weekview.backgroundColor = UIColor.white
    for i in 0..<7 {
      let dayOfWeek = UILabel(frame:CGRect(x:i*Int(self.view.frame.size.width/7),y:0,width:(Int(self.view.frame.size.width/7)),height:Int(self.view.frame.height * 0.08)))
      dayOfWeek.text = daysOfMonth[i]
      dayOfWeek.textAlignment = .center
      dayOfWeek.font = UIUtilities.getFontforDevice()
      dayOfWeek.textColor = UIColor.gray
      dayOfWeek.backgroundColor = UIColor.white
      weekview.addSubview(dayOfWeek)
      weekview.bringSubview(toFront: dayOfWeek)
    }
     self.view.addSubview(weekview)
  }
  
  //This method will return the current month being displayed in the calendar
  func getCurrentMonth() -> Int {
    return Calendar.current.component(.month, from: currentSelectedDate)
  }
  func getCurrentYear() -> Int {
    return Calendar.current.component(.year, from: currentSelectedDate)
  }
  
  // This method will perform the action of loading the eventsaddition page when we tap on add icon in the mainview
  func loadAddEventsPage() {
    //Add your code to load the AddEventsPage VC
    let addeventpage = AddNewEvent(frame: self.view.frame, eventDate:currentSelectedDate)
    self.present(addeventpage, animated: true, completion: nil)
  }
  
  // Implementing the protocol methods here  
  func updatecurrentSelectedDate(date:Date) {
    currentSelectedDate = date
    setupMonthHeader()
    setupEventsList(forCurrentDate:currentSelectedDate)
    setTemperatureView()
  }
  
  func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])  {
    let locValue:CLLocationCoordinate2D = manager.location!.coordinate
    let path = "https://api.openweathermap.org/data/2.5/weather?lat=\(locValue.latitude)&lon=\(locValue.longitude)&appid=03dec74f42b7ccc0941611e51a830e2c"
    let url = NSURL(string: path)
    let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
      do {
        if data != nil {
          let parsedDataInfo = try JSONSerialization.jsonObject(with:data! , options: .allowFragments) as? [String:AnyObject]
          self.currentTemp = (parsedDataInfo?["main"]?["temp"] as? Double ?? 109.5).rounded()
        }
      }
      catch {
        return
      }
      
    }
    task.resume()
  }
  
  // This method will add the events view if there are any events on the selected date
  func setupEventsList(forCurrentDate:Date) {
      eventsView?.removeFromSuperview()
      eventsView = nil
      do {
        let eventsforSelectedDay = try CoreDataUtilities.getEvents(forDate:currentSelectedDate)
        var eventsListForCurrentDay = [EventContents]()
        for each in eventsforSelectedDay {
          let event = EventContents(date: each.date! as Date, eventName: each.eventName ?? "", eventDescription: each.eventDescription ?? "", time: each.time  ?? "", place: each.place  ?? "")
          eventsListForCurrentDay.append(event)
        }
        eventsView = EventsView.init(frame:CGRect(x: (view.frame.width * 0.06), y: (monthView?.view.frame.origin.y)! + (monthView?.view.frame.height)! + (self.view.frame.height * 0.02), width: self.view.frame.size.width-(view.frame.width * 0.12), height: self.view.frame.height - ((monthView?.view.frame.height)! + weekview.frame.height + currentMonthView.frame.height)) , style: .plain, events: eventsListForCurrentDay,forDate:currentSelectedDate)
        self.view.addSubview(eventsView!)
      }
      catch {
        // In case of any exception add the alertView and display it to the user
        let alertView = UIAlertController(title: "Error", message: "Error while adding the event", preferredStyle: .actionSheet)
        let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertView.addAction(alertAction)
        self.present(alertView, animated: true, completion: nil)
      }
  }
  
  func setTemperatureView() {
    temperatureView.removeFromSuperview()
    temperatureView = UILabel(frame:CGRect(x:currentMonthView.frame.origin.x + (currentMonthView.frame.size.width * 0.3),y:currentMonthView.frame.origin.y + (currentMonthView.frame.size.height * 0.02),width:(currentMonthView.frame.size.width * 0.4), height:currentMonthView.frame.size.height))
    temperatureView.text = "Temp : " + String(currentTemp)
    temperatureView.textAlignment = .center
    temperatureView.textColor =  UIColor(red: 107/255, green: 202/255, blue: 251/255, alpha: 1)
    temperatureView.font = UIUtilities.getFontforDevice()
    self.currentMonthView.addSubview(temperatureView)
  }
}

