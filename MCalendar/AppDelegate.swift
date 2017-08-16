//
//  AppDelegate.swift
//  MCalendar
//
//  Created by Pajaniraja, Manjula on 06/08/17.
//  Copyright © 2017 sap. All rights reserved.
//

import UIKit
import CoreData
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  let locationManager = CLLocationManager()

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    self.window?.rootViewController = MainViewController(frame:UIScreen.main.bounds)
    self.window?.makeKeyAndVisible()
    let status = CLLocationManager.authorizationStatus()
    if status == .notDetermined || status == .denied || status == .authorizedWhenInUse {
      
      // present an alert indicating location authorization required
      // and offer to take the user to Settings for the app via
      // UIApplication -openUrl: and UIApplicationOpenSettingsURLString
      DispatchQueue.main.async(execute: {
        let alert = UIAlertController(title: "Error!", message: "GPS access is restricted. In order to use tracking, please enable GPS in the Settigs app under Privacy, Location Services.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Go to Settings", style: UIAlertActionStyle.default, handler: { (alert: UIAlertAction!) in
          print("")
          UIApplication.shared.open(URL.init(string: UIApplicationOpenSettingsURLString)!, options:[:], completionHandler: nil)
        }))
        // self.presentViewController(alert, animated: true, completion: nil)
        self.window?.rootViewController?.present(alert, animated: true, completion: nil)
      })
      
      locationManager.requestAlwaysAuthorization()
      locationManager.requestWhenInUseAuthorization()
    }
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
    return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
  }
  lazy var persistentContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "EventsStorageModel")
    container.loadPersistentStores(completionHandler: { (storeDescription, error) in
      if let error = error {
        
        fatalError("Unresolved error, \((error as NSError).userInfo)")
      }
    })
    return container
  }()

}

