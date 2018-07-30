//
//  File.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 22/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation

class Asset : NSObject, NSCoding{
    
    var _asset_id: String = ""
    var _selectedFields:[Field]?
    var _conditon = ""
    var _fitting = ""
    var _oldCoupn = ""
    var _newCoupn = ""
    var _obsrvn = ""
    
    var obsrvn: String {
        get {
            return _obsrvn
        }
        set {
            _obsrvn = newValue
        }
    }
    var newCoupn: String {
        get {
            return _newCoupn
        }
        set {
            _newCoupn = newValue
        }
    }
    var oldCoupn: String {
        get {
            return _oldCoupn
        }
        set {
            _oldCoupn = newValue
        }
    }
    var fitting: String {
        get {
            return _fitting
        }
        set {
            _fitting = newValue
        }
    }
    var conditon: String {
        get {
            return _conditon
        }
        set {
            _conditon = newValue
        }
    }
    
    var asset_id: String {
        get {
            return _asset_id
        }
        set {
            _asset_id = newValue
        }
    }
    
    var selectedFields: [Field] {
        get {
            return _selectedFields!
        }
        set {
            _selectedFields = newValue
        }
    }
    
    func encode(with coder: NSCoder) {
        //we are saving the name for the key "name"
        
        coder.encode(asset_id, forKey: "asset_id")
        if let fields = _selectedFields
        {
            coder.encode(fields, forKey: "selectedFields")
        }
        coder.encode(conditon, forKey: "conditon")
        coder.encode(fitting, forKey: "fitting")
        coder.encode(oldCoupn, forKey: "oldCoupn")
        coder.encode(newCoupn, forKey: "newCoupn")
        coder.encode(obsrvn, forKey: "obsrvn")
    }
    required init(coder decoder: NSCoder) {
        //this retrieves our saved name object and casts it as a string
        if let nameObject = decoder.decodeObject(forKey: "asset_id") as? String {
            _asset_id = nameObject
        }
        
        if let nameObject = decoder.decodeObject(forKey: "selectedFields") as? [Field] {
            _selectedFields = nameObject
        }
        
        if let nameObject = decoder.decodeObject(forKey: "conditon") as? String {
            _conditon = nameObject
        }
        if let nameObject = decoder.decodeObject(forKey: "fitting") as? String {
            _fitting = nameObject
        }
        if let nameObject = decoder.decodeObject(forKey: "oldCoupn") as? String {
            _oldCoupn = nameObject
        }
        if let nameObject = decoder.decodeObject(forKey: "newCoupn") as? String {
            _newCoupn = nameObject
        }
        if let nameObject = decoder.decodeObject(forKey: "obsrvn") as? String {
            _obsrvn = nameObject
        }
    }
    
    override init() {
        
    }
}
