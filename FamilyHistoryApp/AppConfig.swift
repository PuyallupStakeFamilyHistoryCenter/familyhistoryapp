//
//  AppConfig.swift
//  FamilyHistoryApp
//
//  Created by Tibbitts, Graham on 1/2/15.
//  Copyright (c) 2015 Tibbitts, Graham. All rights reserved.
//

import Foundation

class AppConfig : NSObject, NSCoding {
    
    internal var hostname : String;
    internal var mode : String;
    internal var displayName : String;
    
    init(hostname: String, mode: String, displayName: String) {
        self.hostname = hostname;
        self.mode = mode;
        self.displayName = displayName;
    }
    
    required init(coder decoder: NSCoder) {
        //Error here "missing argument for parameter name in call
        self.hostname = decoder.decodeObjectForKey("hostname") as! String
        self.mode = decoder.decodeObjectForKey("mode") as! String
        self.displayName = decoder.decodeObjectForKey("displayName") as! String
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeObject(self.hostname, forKey: "hostname")
        coder.encodeObject(self.mode, forKey: "mode")
        coder.encodeObject(self.displayName, forKey: "displayName")
    }
}