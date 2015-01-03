//
//  ViewController.swift
//  FamilyHistoryApp
//
//  Created by Tibbitts, Graham on 12/24/14.
//  Copyright (c) 2014 Tibbitts, Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate {

    @IBOutlet var menuView: UIViewController!
    @IBOutlet weak var displayView: UIWebView!
    
    @IBAction func reloadAction(sender: UIButton) {
        loadDisplay()
    }
    
    func loadDisplay() {
        let defaults = NSUserDefaults.standardUserDefaults();
        
        var baseUrl = defaults.stringForKey("hostname") as String?
        var mode = defaults.stringForKey("mode") as String?
        var displayName = defaults.stringForKey("displayName") as String?
        
        if (baseUrl != nil && mode != nil) {
            if (displayName != nil && !(displayName!.isEmpty)) {
                //TODO Set display name cookie
                var domain = baseUrl?.componentsSeparatedByString(":")[0]
                var cookieProperties = NSMutableDictionary();
                cookieProperties.setObject("display-name", forKey: NSHTTPCookieName);
                cookieProperties.setObject(displayName!, forKey: NSHTTPCookieValue);
                cookieProperties.setObject(domain!, forKey: NSHTTPCookieDomain);
                cookieProperties.setObject("/", forKey: NSHTTPCookiePath);
                
                var cookie = NSHTTPCookie(properties: cookieProperties)!;
                var cookieStorage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
                
                cookieStorage.setCookie(cookie)
            }
            
            let displayPath = "http://" + baseUrl! + "/" + mode!;
            let url = NSURL (string:displayPath)
            let request = NSURLRequest(URL: url!)
            displayView.delegate = self
            displayView.scalesPageToFit = true
            displayView.loadRequest(request)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        showUnconfiguredAlert()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        var response = NSURLCache().cachedResponseForRequest(displayView.request!);
        if (response == nil) {
            return
        }
        
        var httpResponse = response?.response as NSHTTPURLResponse
        var statusCode = httpResponse.statusCode
        if (statusCode / 100 != 2) {
            showUnconfiguredAlert()
        }
        
        var cookie : NSHTTPCookie;
        var cookieJar = NSHTTPCookieStorage.sharedHTTPCookieStorage() as NSHTTPCookieStorage;
        for cookie in cookieJar.cookies! {
            if (cookie.name! == "display-name") {
                saveValue("displayName", value: cookie.value!!)
            }
        }
    }
    
    func showUnconfiguredAlert() {
        var alert = UIAlertController(title: "Alert", message: "Failed to load page; It probably needs to be configured", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: {_ in self.performSegueWithIdentifier("mainMenuSegue", sender: self)}))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func cancelMenu (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveMenuChanges (sender: UIStoryboardSegue){
        self.dismissViewControllerAnimated(true, completion: nil)
        
        loadDisplay()
    }
    
    @IBAction func handleLongPress(sender: UILongPressGestureRecognizer) {
        performSegueWithIdentifier("mainMenuSegue", sender: sender)
    }
    
    func saveValue(key: String, value: String) {
        let defaults = NSUserDefaults.standardUserDefaults();
        
        defaults.setObject(value, forKey: key)
    }
}

