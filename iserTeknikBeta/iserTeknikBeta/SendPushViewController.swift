//
//  SendPushViewController.swift
//  iserTeknikBeta
//
//  Created by Erdogan on 4.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//

import UIKit
import Lottie
import Firebase
import OneSignal
class SendPushViewController: UIViewController {

    @IBOutlet weak var notificationTitle: UITextField!
    @IBOutlet weak var notificationContent: UITextField!
    @IBOutlet weak var notificationUrl: UITextField!
    @IBOutlet weak var onlineLabel: UILabel!
    @IBOutlet weak var animationLottie: AnimationView!
    var timer: Timer?
    var online = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()
        // 5sn bir otomatik online kullanıcı sayısını çeker
        self.timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true, block: { (timer) in
            self.autoOnlineUser()
            print("working")
            
        })
        
        
        
    }
    
   
    
    @IBAction func notificationSendButtonClicked(_ sender: Any) {
        let databaseReference = Database.database().reference()
        databaseReference.observe(DataEventType.childAdded) { (snapshot) in
            //print("veriler : " , snapshot.value)
            
            let values = snapshot.value as! NSDictionary
            print("değerlerim: " , values.allKeys)
            let postID = values.allKeys
            
            for id in postID{
                let singlePost = values[id] as! NSDictionary
                print("Benimki ",singlePost["playerID"] as! String)
                let deviceId = singlePost["playerID"] as! String
                //OneSignal.postNotification(["contents": ["en": "Test Message"], "include_player_ids": ["e0d822e5-8610-4255-845d-53b1a9591f99"]])
                OneSignal.postNotification(["headings": ["en": "\(self.notificationTitle.text as! String)"],"contents": ["en": "\(self.notificationContent.text as! String)"],                "data": ["myurl": "\(self.notificationUrl.text as! String)"],
                                            "include_player_ids": ["\(deviceId)"],"ios_badgeType" : "Increase", "ios_badgeCount" : 1])
                
                
            }
            
        }
        
        let alert = UIAlertController(title: "Bildirim Gönderildi", message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //ok tıkladğında segue ile ilk aktiviteye gönderebilirsin.
            self.performSegue(withIdentifier: "toFirstViewControllerFromPush", sender: nil)
        }))
        
        self.present(alert, animated: true)
    }
    

    @IBAction func onlineButtonClicked(_ sender: Any) {
        print("online button")
        //info pliste allow arbitrary ekle
        
        let url = URL(string: "http://iserteknik.webfirmam.com.tr/analytic/index.php")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                
            }else {
                if data != nil {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as!
                            Dictionary<String , AnyObject>
                        
                        DispatchQueue.main.async {
                            print(jsonResult)
                            let online = jsonResult["online"] as! String
                            print(online)
                            self.onlineLabel.text = "Online: \(online)"
                        }
                    }catch {
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    
    func autoOnlineUser(){
        //info pliste allow arbitrary ekle
        let url = URL(string: "http://iserteknik.webfirmam.com.tr/analytic/index.php")
        let session = URLSession.shared
        let task =     session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                let alert = UIAlertController(title: "Hata", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
                alert.addAction(okButton)
                
            }else {
                if data != nil {
                    do{
                        let jsonResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as!
                            Dictionary<String , AnyObject>
                        
                        DispatchQueue.main.async {
                            //print(jsonResult)
                            let online = jsonResult["online"] as! String
                            self.onlineLabel.text = "Online Auto: \(online)"
                            
                            
                            //print(online)
                        }
                    }catch {
                        
                    }
                }
            }
            
        }
        task.resume()
    }
    
    
    func startAnimation(){
        animationLottie.animation = Animation.named("loading")
        //animationLottie.contentMode = UIView.ContentMode.scaleAspectFit
        animationLottie.loopMode = LottieLoopMode.loop
        
        animationLottie.play()
    }
    
}