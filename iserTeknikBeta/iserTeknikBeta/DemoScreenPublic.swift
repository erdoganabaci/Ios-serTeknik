//
//  DemoScreen.swift
//  DemoScreen
//
//
//  Copyright © 2019 Erdogan Abacı. All rights reserved.
//

import UIKit
import paper_onboarding

class DemoScreenPublic: UIViewController {
    
    // Constants
    
    
    // Variables
    var userData = UserDefaults.standard
    
    // Outlets
    @IBOutlet weak var onboardingObj: OnboardingViewClass!
    
    @IBOutlet weak var skipButtonOutlet: UIButton!
    @IBOutlet weak var doneButtonOutlet: UIButton!
    
    // Actions
    @IBAction func doneBtnPressed(_ sender: Any) {
        userData.set(true, forKey: "demoCompleted")
        userData.synchronize()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        doneButtonOutlet.isHidden = true
        skipButtonOutlet.isHidden = false
        onboardingObj.dataSource = self
        onboardingObj.delegate = self
    }
}

extension DemoScreenPublic: PaperOnboardingDataSource, PaperOnboardingDelegate  {
    
    // DataSource functions
    func onboardingItemsCount() -> Int {
        return 6
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        let firstImage = #imageLiteral(resourceName: "illustration") // Image literal
        let secondImage = #imageLiteral(resourceName: "card-1")
        let thirdImage = #imageLiteral(resourceName: "post-1")
        let fourthImage = #imageLiteral(resourceName: "yeni resim")
        let fiveImage = #imageLiteral(resourceName: "yeni resim 2")
        let sixImage = #imageLiteral(resourceName: "yeni resim 3")
        let iserlogo = #imageLiteral(resourceName: "iserteknik")
        let iserFirst = #imageLiteral(resourceName: "peopleDemo")
        let iserSecond = #imageLiteral(resourceName: "revind")
        let iserThird = #imageLiteral(resourceName: "forward")
        let iserFourth = #imageLiteral(resourceName: "refresh")
        let iserFifthdNew = #imageLiteral(resourceName: "stop")
        let iserRcoket = #imageLiteral(resourceName: "rocket")
        
        
        let activeImage = #imageLiteral(resourceName: "active")
        let bgArray = [#colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1), #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)] // Color literal
        let titleFont = UIFont(name: "HelveticaNeue-Bold", size:  20.0)!
        let descFont = UIFont(name: "HelveticaNeue", size: 17.0)!
        let titleColor = UIColor.white
        let descColor = UIColor.white
        
        var arrayToReturn = [OnboardingItemInfo]()
        
        arrayToReturn.append(OnboardingItemInfo(informationImage: iserFirst, title: "Açılış Ekranı", description: "Site İçeriklerini Görmek İçin Siteye Geçe Basınız", pageIcon: activeImage, color: bgArray[0], titleColor: titleColor, descriptionColor: descColor, titleFont: titleFont, descriptionFont: descFont))
        
        arrayToReturn.append(OnboardingItemInfo(informationImage: iserSecond, title: "Web Site Ekranı", description: "Web Sitede Geri Gelmek İçin Basınız", pageIcon: activeImage, color: bgArray[1], titleColor: titleColor, descriptionColor: descColor, titleFont: titleFont, descriptionFont: descFont))
        
        arrayToReturn.append(OnboardingItemInfo(informationImage: iserThird, title: "Web Site Ekranı", description: "Web Sitede İleri Gitmek İçin Basınız", pageIcon: activeImage, color: bgArray[2], titleColor: titleColor, descriptionColor: descColor, titleFont: titleFont, descriptionFont: descFont))
       
        arrayToReturn.append(OnboardingItemInfo(informationImage: iserFourth, title: "Web Site Ekranı", description: "Web Siteyi Yenilemek İçin Basınız", pageIcon: activeImage, color: bgArray[3], titleColor: titleColor, descriptionColor: descColor, titleFont: titleFont, descriptionFont: descFont))
       
        arrayToReturn.append(OnboardingItemInfo(informationImage: iserFifthdNew, title: "Web Site Ekranı", description: "Web Siteyi Durdurmak İçin Basınız", pageIcon: activeImage, color: bgArray[3], titleColor: titleColor, descriptionColor: descColor, titleFont: titleFont, descriptionFont: descFont))
        
        arrayToReturn.append(OnboardingItemInfo(informationImage: iserRcoket, title: "Uygulamanız Hazır", description: "Uygulamaya Geçebilirsiniz", pageIcon: activeImage, color: bgArray[3], titleColor: titleColor, descriptionColor: descColor, titleFont: titleFont, descriptionFont: descFont))
        
        return arrayToReturn[index]
    }
    
    // Delegate Methods
    func onboardingDidTransitonToIndex(_ index: Int) {
        if index  == 5 {
            doneButtonOutlet.isHidden = false
            skipButtonOutlet.isHidden = true
        }
    }
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        if index != 5 {
            if doneButtonOutlet.isHidden == false {
                doneButtonOutlet.isHidden = true
                skipButtonOutlet.isHidden = false
            }
        }
    }
    
    func onboardingConfigurationItem(_: OnboardingContentViewItem, index _: Int) {
        
    }
}
