//
//  Option.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 23/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation
import RSSelectionMenu
class Option: NSObject, UniqueProperty, NSCoding
{
    var _opt_id: String = ""
    var _opt_title: String = ""
    
    var opt_id: String {
        get {
            return _opt_id
        }
        set {
            _opt_id = newValue
        }
    }
    
    var opt_title: String {
        get {
            return _opt_title
        }
        set {
            _opt_title = newValue
        }
    }
    
    func uniquePropertyName() -> String {
        return "opt_title"
    }
    func encode(with coder: NSCoder) {
        //we are saving the name for the key "name"
        coder.encode(opt_id, forKey: "opt_id")
        coder.encode(opt_title, forKey: "opt_title")
    }
    override init() {
        
    }
    
    required init(coder decoder: NSCoder) {
        //this retrieves our saved name object and casts it as a string
        if let nameObject = decoder.decodeObject(forKey: "opt_id") as? String {
            _opt_id = nameObject
        }
        
        if let nameObject = decoder.decodeObject(forKey: "opt_title") as? String {
            _opt_title = nameObject
        }
    }
}
