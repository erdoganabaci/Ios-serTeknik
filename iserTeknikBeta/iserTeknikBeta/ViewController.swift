//
//  ViewController.swift
//  iserTeknikBeta
//
//  Created by Erdogan on 4.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//

import UIKit
import WebKit
class ViewController: UIViewController ,WKNavigationDelegate{
    @IBOutlet weak var ActInd: UIActivityIndicatorView!
    
    @IBOutlet weak var webView: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //navigation title
        navigationItem.title = "İser Teknik"
        // Do any additional setup after loading the view.
        let url = URL(string: "http://iserteknik.webfirmam.com.tr/")
        
        let request = URLRequest(url: url!)

        webView.load(request)
        //progress bar indikatorünü webview elemanıymış gibi ekledik arkasında çalıssın diye.
        webView.addSubview(ActInd)
        ActInd.startAnimating()
        
        webView.navigationDelegate = self
        //eğer barın animasyonu durdurursak gizlicek.
        ActInd.hidesWhenStopped = true
       
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

