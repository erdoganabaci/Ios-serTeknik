//
//  SecondViewController.swift
//  iserTeknikBeta
//
//  Created by Erdogan on 4.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//

import UIKit
import WebKit
class SecondViewController: UIViewController , WKNavigationDelegate {
    @IBOutlet weak var webViewSecond: WKWebView!
    
    @IBOutlet weak var ActIndSecond: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let delegate : AppDelegate = UIApplication.shared.delegate as! AppDelegate
        let pushUrl = delegate.myUrl
        print("second url geldi" , pushUrl)
        //OneSignal.postNotification(["contents": ["en": "Test Message"], "include_player_ids": ["e0d822e5-8610-4255-845d-53b1a9591f99"]])
        let url = URL(string: pushUrl )
        
        let request = URLRequest(url: url!)
        
        webViewSecond.load(request)
        //progress bar indikatorünü webview elemanıymış gibi ekledik arkasında çalıssın diye.
        webViewSecond.addSubview(ActIndSecond)
        ActIndSecond.startAnimating()
        
        webViewSecond.navigationDelegate = self
        //eğer barın animasyonu durdurursak gizlicek.
        ActIndSecond.hidesWhenStopped = true
    }
    

    @IBAction func back(_ sender: Any) {
        if webViewSecond.canGoBack {
            webViewSecond.goBack()
        }
    }
    
    @IBAction func forward(_ sender: Any) {
        if webViewSecond.canGoForward {
            webViewSecond.goForward()
            
        }
    }
    @IBAction func refresh(_ sender: Any) {
        webViewSecond.reload()

    }
    @IBAction func stop(_ sender: Any) {
        webViewSecond.stopLoading()

    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        //eğer yükleme biterse durdur
        ActIndSecond.stopAnimating()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        //eğer internet bağlantısı yoksa indikatörü kapat ve  alert göster ve bağlanılamadı deyip uygulamayı kapat.
        ActIndSecond.stopAnimating()
        
        //internet kontrolü yapılcak
        
    }
}
