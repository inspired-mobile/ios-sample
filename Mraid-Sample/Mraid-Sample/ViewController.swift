//
//  ViewController.swift
//  Mraid-Sample
//
//  Created by dev on 19/07/18.
//  Copyright © 2018 InspireMobile. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SKMRAIDViewDelegate,SKMRAIDServiceDelegate,SKMRAIDModalViewControllerDelegate,SKBrowserDelegate {
    var adView = SKMRAIDView2()
    var browser = SKBrowser2()
    var bannerOpenString = NSString()
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        self.appActiveMode()
    }
    
    
    //**************************SHOW BANNER*************************
    /*
      This is the method of loading and displaying the banner data. The demo is triggered by clicking the button. You can implement the logic of your business based on the logic code in this method.
    */
    func showBannerData()
    {
        let myURLString = "https://hexims.it/work/inspire/banneri.html"
        var htmlData = NSString()
        
        do {
            htmlData = try String (contentsOf: NSURL(string: myURLString)! as URL, encoding: String.Encoding.utf8) as NSString
        }
        catch
        {
            print(error)
        }
        
        bannerOpenString = htmlData
        
        let bundleUrl = NSURL(fileURLWithPath: Bundle.main .bundlePath)
        adView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100)
        adView = adView .initWithFrame(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 100), withHtmlData: bannerOpenString, withBaseURL: bundleUrl, supportedFeatures: [Constants.MRAIDSupportsSMS, Constants.MRAIDSupportsStorePicture], delegate: self, serviceDelegate: self, rootViewController: self) as! SKMRAIDView2
        
        self.view.addSubview(adView)
    }
    
    func appActiveMode()
    {
        // Notification when app will resign active or did became active
        NotificationCenter.default.addObserver(self,selector: #selector(applicationWillResignActive), name: .UIApplicationWillResignActive,object: nil)
        
        NotificationCenter.default.addObserver(self,selector: #selector(applicationDidBecomeActive),name: .UIApplicationDidBecomeActive,object: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //********************CLICK BTN TO OPEN BANNER *****************
    @IBAction func showBannerView(_ sender: Any) {
        self.showBannerData()
    }
    
    //*********************GO INTERSTITIAL SCREEN ******************
    @IBAction func goInterstitialScreen(_ sender: Any)
    {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Interstitial") as! InterstitialViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    //************ APPLICATION ACTIVE NOTIFICATION START ***********
    @objc func applicationWillResignActive(notification: UIApplication)
    {
        // hide banner view
        adView.isViewable = false
    }
    
    @objc func applicationDidBecomeActive(notification: UIApplication)
    {
        // show banner view
        adView.isViewable = true
    }
    //************ APPLICATION ACTIVE NOTIFICATION END ***********
    
    
    //********************DELEGATE METHOD START****************
    
    //If Mraid Ready
    func mraidViewAdReady(mraidView: SKMRAIDView2)
    {

    }
    
    //If Mraid Failed
    func mraidViewAdFailed(mraidView: SKMRAIDView2)
    {

    }
    
    //If Mraid Expand
    func mraidViewWillExpand(mraidView: SKMRAIDView2)
    {

    }
    
    //If Mraid Closed
    func mraidViewDidClose(mraidView: SKMRAIDView2)
    {

    }
    
    //If Mraid Navigate with url
    func mraidViewNavigate(mraidView: SKMRAIDView2, withURL url: NSURL) {
 
    }
    
    func MRAIDForceOrientationFromString(s: NSString) -> SKMRAIDForceOrientation {
        return SKMRAIDForceOrientation.MRAIDForceOrientationPortrait
    }
    
    func mraidViewShouldResize(mraidView: SKMRAIDView2, toPosition position: CGRect, allowOffscreen: Bool) -> Bool
    {
        return true
    }
    
    //If Mraid is "open"
    func mraidServiceOpenBrowserWithUrlString(urlString: NSString) {
        browser = browser .initWithDelegate(delegate: self, withFeatures: [Constant.kSourceKitBrowserFeatureSupportInlineMediaPlayback
            , Constant.kSourceKitBrowserFeatureDisableStatusBar
            , Constant.kSourceKitBrowserFeatureScalePagesToFit]) as! SKBrowser2
        let myURL = URL(string: urlString as String)
        let myRequest = URLRequest(url: myURL!)
        browser .loadRequest(request: myRequest as NSURLRequest)
    }
    
    //If Mraid Storepicture
    func mraidServiceStorePictureWithUrlString(urlString: NSString)
    {

    }
    
    func mraidModalViewControllerDidRotate(modalViewController: SKMRAIDModalViewController)
    {
    
    }
    
    //If Mraid Closed from browser
    func sourceKitBrowserClosed(sourceKitBrowser: SKBrowser2) {
        self.dismiss(animated: true)
        {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func sourceKitBrowserWillExitApp(sourceKitBrowser: SKBrowser2)
    {
        
    }
    //********************DELEGATE METHOD END******************
    
}

