//
//  ViewController.swift
//  FamilyHistoryApp
//
//  Created by Tibbitts, Graham on 12/24/14.
//  Copyright (c) 2014 Tibbitts, Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var displayView: UIWebView!
    @IBOutlet weak var controllerView: UIWebView!
    
    var baseUrl = "192.168.1.118:8080" //"localhost:8080" //
    
    func loadDisplay() {
        let displayPath = "http://" + baseUrl + "/split";
        let url = NSURL (string:displayPath)
        let request = NSURLRequest(URL: url!)
        displayView.delegate = self
        displayView.scalesPageToFit = true
        displayView.loadRequest(request)
    }
    
    func loadController() {
//        let controllerPath = "http://" + baseUrl + "/games";
//        let url = NSURL (string: controllerPath)
//        let request = NSURLRequest(URL: url!)
//        controllerView.scalesPageToFit = true
//        controllerView.loadRequest(request)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDisplay()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadController()
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
        setHostName()
    }
    
    func setHostName() {
        let alertController = UIAlertController(title: "iOScreator", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}

