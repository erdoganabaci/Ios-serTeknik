//
//  AppDelegate.swift
//  iserTeknikBeta
//
//  Created by Erdogan on 4.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//

import UIKit
import OneSignal
import Firebase
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var myUrl = ""
    var window: UIWindow?
    var userData = UserDefaults.standard
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //directUrl()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        //var firstVC = storyBoard.instantiateViewController(withIdentifier: "DemoBoardApp")
        //var firstVC = storyBoard.instantiateViewController(withIdentifier: "MainBoardApp")
        var firstVC = storyBoard.instantiateViewController(withIdentifier: "DemoPeopleBoardApp")

        
      /*  if userData.bool(forKey: "demoCompleted") {
            firstVC = storyBoard.instantiateViewController(withIdentifier: "MainBoardApp")
            
        }*/
        
        if userData.bool(forKey: "demoCompleted") {
         firstVC = storyBoard.instantiateViewController(withIdentifier: "welcomeScreen")
         
         }
        
        window?.rootViewController = firstVC
       //window?.makeKeyAndVisible()
        
        FirebaseApp.configure()
        
        OneSignal.promptForPushNotifications(userResponse: { accepted in
            print("User accepted notifications: \(accepted)")
        })

        let notificationOpenedBlock: OSHandleNotificationActionBlock = { result in
            // This block gets called when the user reacts to a notification received
            let payload: OSNotificationPayload? = result?.notification.payload
            print("Message başlığı = \(payload!.title as! String)")
            
            print("Message içeriği = \(payload!.body as! String)")
            print("merhaba")
            //self.window?.rootViewController!.performSegue(withIdentifier: "toFirstViewControllerFromPush", sender: nil)
            
            
            //            print("badge number = \(payload?.badge ?? 0)")
            //            print("notification sound = \(payload?.sound ?? "None")")
            
            if let additionalData = result!.notification.payload!.additionalData {
                print("additionalData = \(additionalData)")
                let myurl = additionalData as! NSDictionary
                print("url geldi " , myurl["myurl"] as! String )
                let receivedUrl = myurl["myurl"] as! String
                //eğer kullanıcı data yollarsa mai activitye yolla ordan url al appdelegete erişerek.
                self.myUrl = receivedUrl
                //self.applicationWillTerminate(UIApplication.init())
                if(self.myUrl != ""){
                    self.directUrl()
                }
            }
        }
        
        let onesignalInitSettings = [kOSSettingsKeyAutoPrompt: false]
        // Onesignal
        OneSignal.initWithLaunchOptions(launchOptions,
                                        appId: "e766b6a6-c39c-4848-aeb8-020e4b40ce57",
                                        handleNotificationAction: notificationOpenedBlock,
                                        settings: onesignalInitSettings)
        
        OneSignal.inFocusDisplayType = OSNotificationDisplayType.notification;
        
        // Recommend moving the below line to prompt for push after informing the user about
        //   how your app will use them.
      
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
    func directUrl(){
       
            //secondWebView
            let board : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController: SecondViewController = board.instantiateViewController(withIdentifier: "secondWebView") as! SecondViewController;
            window?.rootViewController = viewController
            
            //çağır mainden yada çağırmana gerek yok direk değişkeni al myurl ile onu main viewcontrollere aktar
        
    }
    
  

}

