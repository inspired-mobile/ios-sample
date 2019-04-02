//
//  InterstitialViewController.swift
//  Mraid-Sample
//
//  Created by dev on 19/07/18.
//  Copyright © 2018 InspireMobile. All rights reserved.
//

import UIKit

class InterstitialViewController: UIViewController,SKMRAIDServiceDelegate,SKMRAIDInterstitialDelegate
{
    var interstitiaOpenString = NSString()
    var interstitial = SKMRAIDInterstitial()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        interstitial .isViewable = true
        self .appActiveMode()
    }
    
    //**********************SHOW INTERSTITIAL********************
    /*
      This is the method of loading and displaying the interstitial data. The demo is triggered by clicking the button. You can implement the logic of your business based on the logic code in this method.
     */
    func showInterstitial()
    {
        let myURLString = "http://river.aipy.org/ad/ad-ins.html"
        var htmlData = NSString()
        
        do {
            htmlData = try String (contentsOf: NSURL(string: myURLString)! as URL, encoding: String.Encoding.utf8) as NSString
            print(htmlData)
        }
        catch
        {
            print(error)
        }
        
        // you can add your java scrypt from textview or textfeild in interstitiaOpenString
        
        interstitiaOpenString = htmlData
        
        let bundleUrl = NSURL(fileURLWithPath: Bundle.main .bundlePath)
        interstitial = interstitial.initWithSupportedFeatures(features: [Constants.MRAIDSupportsSMS,   Constants.MRAIDSupportsStorePicture, Constants.MRAIDSupportsInlineVideo], withHtmlData: interstitiaOpenString , withBaseURL: bundleUrl, delegat: self, serviceDelegat: self, rootViewControllerr: self) as! SKMRAIDInterstitial
    }
    
    func appActiveMode()
     {
        // Notification when app will resign active or did became active
        NotificationCenter.default.addObserver(self,selector: #selector(applicationWillResignActive), name: .UIApplicationWillResignActive,object: nil)
        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: .UIApplicationDidBecomeActive,object: nil)
     }
    
    //************************ INTERSTITIAL END ********************
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    //****************CLICK BTN TO OPEN INTERTITIAL ****************
    @IBAction func showInterstitial(_ sender: Any)
    {
        self .showInterstitial()
    }
  
    //*********************GO BANNER SCREEN ******************
    @IBAction func goBannerScreen(_ sender: Any)
    {
        self.navigationController?.popViewController(animated: true)
    }
  
    //************ APPLICATION ACTIVE NOTIFICATION START ***********
    @objc func applicationWillResignActive(notification: UIApplication)
    {
        interstitial.isViewable = false
    }
    
    @objc func applicationDidBecomeActive(notification: UIApplication)
    {
        interstitial.isViewable = true
    }
    
    //************* APPLICATION ACTIVE NOTIFICATION END ************

    //********************DELEGATE METHOD START********************
   
    // Mraid Interstitial Open With Url
    func mraidServiceOpenBrowserWithUrlString(urlString: NSString)
    {
        if let url = URL(string: "\(urlString)")
        {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    func mraidServiceStorePictureWithUrlString(urlString: NSString)
    {
  
    }
    
    // Mraid Interstitial Ready
    func mraidInterstitialAdReady(mraidInterstitial: SKMRAIDInterstitial) {
        interstitial.show()
    }
    
    // Mraid Interstitial Failed
    func mraidInterstitialAdFailed(mraidInterstitial: SKMRAIDInterstitial)
    {

    }

    // Mraid Interstitial Will Show
    func mraidInterstitialWillShow(mraidInterstitial: SKMRAIDInterstitial)
    {

    }
    
    // Mraid Interstitial Hide Not Ready
    func mraidInterstitialDidHide(mraidInterstitial: SKMRAIDInterstitial)
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    func mraidInterstitialNavigate(mraidInterstitial: SKMRAIDInterstitial, withURL url: NSURL)
    {
        
    }
    //********************DELEGATE METHOD END******************

    
}

