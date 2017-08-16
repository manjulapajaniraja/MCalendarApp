//
//  AddNewEventController.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 14/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit
class AddNewEvent: UIViewController {
  var newEventObject = EventContents(date: Date(), eventName: "", eventDescription: "", time: "", place: "")
  var navigationBar = UINavigationBar()
  var eventDate = Date()
  private var eventNameTextView = UITextField()
  private var eventDescriptionTextView = UITextField()
  private var placeTextView = UITextField()
  private var eventTimeTextView = UIDatePicker()
  
  init(frame:CGRect, eventDate:Date) {
    super.init(nibName: nil, bundle: nil)
    view.frame = frame
    self.eventDate = eventDate
    view.backgroundColor = UIColor.white
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationBar = UINavigationBar(frame: CGRect(x: 0, y: self.view.frame.height * 0.04, width: view.frame.size.width, height:self.view.frame.height * 0.05))
    navigationBar.backgroundColor = UIColor.white
   // Create a navigation item with a title
    let navigationItem = UINavigationItem()
    navigationItem.title = "Add New Event"
    // Create left and right button for navigation item
    let leftButton =  UIBarButtonItem(title: "Cancel", style:   .plain, target: self, action: #selector(AddNewEvent.btn_clicked(_:)))
    let rightButton = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(AddNewEvent.addEvent))
    // Create two buttons for the navigation item
    navigationItem.leftBarButtonItem = leftButton
    navigationItem.rightBarButtonItem = rightButton
    // Assign the navigation item to the navigation bar
    navigationBar.items = [navigationItem]
    // Make the navigation bar a subview of the current view controller
    self.view.addSubview(navigationBar)
    setupFieldsforAddingevent()
  }
  func btn_clicked(_ sender: UIBarButtonItem) {
   dismissViewController()
  }
  private func setupFieldsforAddingevent() {
    let eventNameLabel = UILabel(frame: CGRect(x: self.view.frame.width * 0.1 , y: self.navigationBar.frame.origin.y + self.navigationBar.frame.height + (self.navigationBar.frame.height * 0.2) , width: self.view.frame.width * 0.4, height: 44))
    eventNameLabel.text = "EventName"
    eventNameLabel.font = UIUtilities.getFontforDevice()
    self.view.addSubview(eventNameLabel)
    eventNameTextView = UITextField(frame:CGRect(x: self.view.frame.width * 0.1, y: eventNameLabel.frame.origin.y + eventNameLabel.frame.size.height + (self.navigationBar.frame.height * 0.2), width: self.view.frame.width * 0.6 , height: 44))
    eventNameTextView.placeholder = "Specify the name of the event"
    eventNameTextView.borderStyle = .roundedRect
    eventNameTextView.font = UIUtilities.getFontforDevice()
    self.view.addSubview(eventNameTextView)
    let eventDescription = UILabel(frame: CGRect(x: self.view.frame.width * 0.1 , y: eventNameTextView.frame.origin.y + eventNameTextView.frame.height + (self.navigationBar.frame.height * 0.2) , width: self.view.frame.width * 0.4, height: 44))
    eventDescription.text = "EventDescription"
    eventDescription.font = UIUtilities.getFontforDevice()
    self.view.addSubview(eventDescription)
    eventDescriptionTextView = UITextField(frame:CGRect(x: self.view.frame.width * 0.1, y: eventDescription.frame.origin.y + eventDescription.frame.size.height + (self.navigationBar.frame.height * 0.2), width: self.view.frame.width * 0.6 , height: 88))
    eventDescriptionTextView.placeholder = "Provide the description for the event"
    eventDescriptionTextView.borderStyle = .roundedRect
    eventDescriptionTextView.font = UIUtilities.getFontforDevice()
    self.view.addSubview(eventDescriptionTextView)
    let place = UILabel(frame: CGRect(x: self.view.frame.width * 0.1 , y: eventDescriptionTextView.frame.origin.y + eventDescriptionTextView.frame.height + (self.navigationBar.frame.height * 0.2) , width: self.view.frame.width * 0.4, height: 44))
    place.text = "Event Location"
    place.font = UIUtilities.getFontforDevice()
    self.view.addSubview(place)
    placeTextView = UITextField(frame:CGRect(x: self.view.frame.width * 0.1, y: place.frame.origin.y + place.frame.size.height + (self.navigationBar.frame.height * 0.2), width: self.view.frame.width * 0.6 , height: 88))
    placeTextView.placeholder = "Provide the location of the event"
    placeTextView.borderStyle = .roundedRect
    placeTextView.font = UIUtilities.getFontforDevice()
    self.view.addSubview(placeTextView)
    let eventTimeLabel = UILabel(frame: CGRect(x: self.view.frame.width * 0.1 , y: placeTextView.frame.origin.y + placeTextView.frame.height + (self.navigationBar.frame.height * 0.2) , width: self.view.frame.width * 0.4, height: 44))
    eventTimeLabel.text = "Event Time"
    eventTimeLabel.font = UIUtilities.getFontforDevice()
    self.view.addSubview(eventTimeLabel)
    eventTimeTextView = UIDatePicker(frame:CGRect(x: self.view.frame.width * 0.1 + eventTimeLabel.frame.width, y: placeTextView.frame.origin.y + placeTextView.frame.size.height + (self.navigationBar.frame.height * 0.2), width: self.view.frame.width * 0.37 , height: 44))
    eventTimeTextView.datePickerMode = .time
    self.view.addSubview(eventTimeTextView)
    
  }
  func addEvent() {
    let timeString = String(describing:(Calendar.current.dateComponents([.hour], from: eventTimeTextView.date)).hour!) + ":" + String(describing: (Calendar.current.dateComponents([.minute], from: eventTimeTextView.date)).minute!)
    let event = EventContents(date: eventDate, eventName: eventNameTextView.text ?? "", eventDescription: eventDescriptionTextView.text ?? "", time:timeString, place: placeTextView.text ?? "")
    do {
      try  CoreDataUtilities.storeEvent(event: event)
    } catch {
      let alertView = UIAlertController(title: "Error", message: "Error while adding the event", preferredStyle: .actionSheet)
      let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
      alertView.addAction(alertAction)
      self.present(alertView, animated: true, completion: nil)
    }
    dismissViewController()    
  }
  
  func dismissViewController() {
    UIView.animate(withDuration: 0.8, animations: {
      self.dismiss(animated: true, completion: nil)
    })
    
  }
  
}
