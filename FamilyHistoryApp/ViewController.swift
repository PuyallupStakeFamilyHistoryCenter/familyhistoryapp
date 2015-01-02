//
//  ViewController.swift
//  FamilyHistoryApp
//
//  Created by Tibbitts, Graham on 12/24/14.
//  Copyright (c) 2014 Tibbitts, Graham. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate {

    @IBOutlet var swipeGestureRecognizer: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var displayView: UIWebView!
    
    @IBAction func reloadAction(sender: UIButton) {
        loadDisplay()
    }
    
    var baseUrl = "192.168.1.118:8080" //"localhost:8080" //
    
    func loadDisplay() {
        let displayPath = "http://" + baseUrl + "/split";
        let url = NSURL (string:displayPath)
        let request = NSURLRequest(URL: url!)
        displayView.delegate = self
        displayView.scalesPageToFit = true
        displayView.loadRequest(request)
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
    }
    
    func setHostName() {
        let alertController = UIAlertController(title: "iOScreator", message:
            "Hello, world!", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
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
    
    @IBAction func handleRightSwipe(sender:UISwipeGestureRecognizer) {
        performSegueWithIdentifier("mainMenuSegue", sender: sender)
    }
}

