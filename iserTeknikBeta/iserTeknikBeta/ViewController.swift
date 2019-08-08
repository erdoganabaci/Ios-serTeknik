//
//  ViewController.swift
//  iserTeknikBeta
//
//  Created by Erdogan on 4.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//

import UIKit
import WebKit
import OneSignal
import Firebase
class ViewController: UIViewController ,WKNavigationDelegate{
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    var userID = ""
    var uuidDb = ""
    var userDeviceID = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Do any additional setup after loading the view.
        //navigation title
        //self.navigationController?.setNavigationBarHidden(false, animated: false)

        navigationItem.title = "İser Teknik"
        // Do any additional setup after loading the view.
        let url = URL(string: "http://iserteknik.webfirmam.com.tr/")
        uuidDb = UUID().uuidString
        let request = URLRequest(url: url!)

        webView.load(request)
        //progress bar indikatorünü webview elemanıymış gibi ekledik arkasında çalıssın diye.
        webView.addSubview(ActInd)
        ActInd.startAnimating()
        
        webView.navigationDelegate = self
        //eğer barın animasyonu durdurursak gizlicek.
        ActInd.hidesWhenStopped = true
        let status : OSPermissionSubscriptionState =
            OneSignal.getPermissionSubscriptionState()
      if(status.subscriptionStatus.userId != nil){
            self.userID = status.subscriptionStatus.userId
            print("geldi" , self.userID)
            
        }

        
       
        
    
        
        print("senin id: "+userID)
        getAndSavePlayerIdFromFirebase()

       
    }
    func getAndSavePlayerIdFromFirebase() {
        let databaseReference = Database.database().reference()
        //databaseReference.child("PlayerIDs").child(uuid).child("test").setValue("Deneme")
        //database kayıt işlemleri
        if userID != nil 	 {
            //databaseden sorgu yap
            //print("your id :" , userID)
            databaseReference.observe(.value) { (snapshot) in
                if(snapshot.exists()){
                    databaseReference.observe(DataEventType.childAdded) { (snapshot) in
                        //print("veriler : " , snapshot.value)
                        
                        let values = snapshot.value as! NSDictionary
                        print("değerlerim: " , values.allKeys)
                        let postID = values.allKeys
                        
                        for id in postID{
                            let singlePost = values[id] as! NSDictionary
                            print("Benimki ",singlePost["playerID"] as! String)
                            let deviceId = singlePost["playerID"] as! String
                            self.userDeviceID.append(deviceId)
                        }
                        print("mylist " , self.userDeviceID)
                        
                        
                        
                        if(!self.userDeviceID.contains(self.userID)){
                            print("içeriyor mu ?" , self.userDeviceID.contains(self.userID))
                            print("user device idler" , self.userID)
                            print("my id is " , self.userID)
                            //self.userDeviceID.append(self.userID)
                            //eğer device id databasede yoksa ekle
                            let databaseNewReference = Database.database().reference()
                            databaseReference.child("PlayerIDs").child(self.uuidDb).child("playerID").setValue(self.userID)
                            //databaseNewReference.child("PlayerIDs").child("mykey").child("post").child(self.uuid).child("playerID").setValue(self.userID)
                        }
                        
                        
                        
                    }
                }else{
                    if(!self.userDeviceID.contains(self.userID)){
                        print("içeriyor mu ?" , self.userDeviceID.contains(self.userID))
                        print("user device idler" , self.userID)
                        print("my id is " , self.userID)
                        self.userDeviceID.append(self.userID)
                        //eğer device id databasede yoksa ekle
                        let databaseNewReference = Database.database().reference()
                        databaseReference.child("PlayerIDs").child(self.uuidDb).child("playerID").setValue(self.userID)
                        //databaseNewReference.child("PlayerIDs").child("mykey").child("post").child(self.uuid).child("playerID").setValue(self.userID)
                    }
                }
                
                
                
                
            }
            
            
        }else{
            exit(0)
        }
        
    }
    @IBAction func sendPushNotificationButtonClicked(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toSendPushNotificationFromFirst", sender: nil)
    }
    
   
    @IBAction func back(_ sender: Any) {
        if webView.canGoBack {
            webView.goBack()
        }
    }
    
    @IBAction func forward(_ sender: Any) {
        if webView.canGoForward {
            webView.goForward()
            
        }
    }
    @IBAction func refresh(_ sender: Any) {
        webView.reload()

        
    }
    
    @IBAction func stop(_ sender: Any) {
        webView.stopLoading()

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //eğer yükleme biterse durdur
        ActInd.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //eğer internet bağlantısı yoksa indikatörü kapat ve  alert göster ve bağlanılamadı deyip uygulamayı kapat.
        ActInd.stopAnimating()
        
        //internet kontrolü yapılcak
        
    }
}

