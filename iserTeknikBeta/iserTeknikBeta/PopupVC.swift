//
//  PopupVC.swift
//  iserTeknikBeta
//
//  Created by Erdogan on 25.08.2019.
//  Copyright © 2019 Erdogan. All rights reserved.
//
import UIKit

class PopupVC: UIViewController {

    @IBOutlet weak public var popUpContentText: UITextView!
    @IBOutlet weak var popupView: UIView!
    var popUpContextName = "İs & Er Teknik; Viessmann,Dcd Baltur,Grundfos,Daikin,Kodsan,Riello,Gökçe Brülor Yetkili Servisidir."
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        popupView.layer.cornerRadius = 10
        popupView.layer.masksToBounds = true
        popUpContentText.text = popUpContextName
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func closePopup(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
