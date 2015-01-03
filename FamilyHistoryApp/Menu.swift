//
//  Menu.swift
//  FamilyHistoryApp
//
//  Created by Tibbitts, Graham on 1/2/15.
//  Copyright (c) 2015 Tibbitts, Graham. All rights reserved.
//

import UIKit


class Menu: UIViewController {
    
    @IBOutlet weak var hostnameTextField: UITextField!
    
    @IBOutlet weak var modeControl: UISegmentedControl!
    
    @IBOutlet weak var displayNameTextField: UITextField!
    
    @IBAction func handleHostnameChanged(sender: UITextField) {
        saveValue("hostname", value:hostnameTextField.text);
    }
    
    @IBAction func handleModeChanged(sender: UISegmentedControl) {
        
        var mode = "";
        switch (modeControl.selectedSegmentIndex) {
        case 0:
            mode = "display"
            break;
            
        case 1:
            mode = "controller"
            break;
            
        case 2:
            mode = "split";
            break;
            
        default:
            break;
        }
        
        saveValue("mode", value: mode);
    }
    
    @IBAction func handleDisplayNameChanged(sender: UITextField) {
        saveValue("displayName", value: displayNameTextField.text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hostnameTextField.text = getValue("hostname")
        displayNameTextField.text = getValue("displayName")
        
        var mode = getValue("mode");
        if (mode == nil) {
            //DO NOTHING
        } else if (mode == "display") {
            modeControl.selectedSegmentIndex = 0;
        } else if (mode == "controller") {
            modeControl.selectedSegmentIndex = 1;
        } else if (mode == "split") {
            modeControl.selectedSegmentIndex = 2;
        }
    }
    
    func saveValue(key: String, value: String) {
        let defaults = NSUserDefaults.standardUserDefaults();
        
        defaults.setObject(value, forKey: key)
    }
    
    func getValue(key: String) -> String? {
        let defaults = NSUserDefaults.standardUserDefaults();
        
        return defaults.stringForKey(key)
    }
}