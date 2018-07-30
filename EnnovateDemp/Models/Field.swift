//
//  Field.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 23/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation
import RSSelectionMenu

class Field: NSObject, UniqueProperty, NSCoding
{
    var _f_id: String = ""
    var _f_title: String = ""
    var _type: String = ""
    var _options: [Option]?
    var _selectedOption: Option?
    
    var f_id: String {
        get {
            return _f_id
        }
        set {
            _f_id = newValue
        }
    }
    
    var f_title: String {
        get {
            return _f_title
        }
        set {
            _f_title = newValue
        }
    }
    
    var type: String {
        get {
            return _type
        }
        set {
            _type = newValue
        }
    }
    
    var options: [Option]! {
        get {
            return _options!
        }
        set {
            _options = newValue
        }
    }
    
    var selectedOption: Option! {
        get {
            return _selectedOption!
        }
        set {
            _selectedOption = newValue
        }
    }
    
    func uniquePropertyName() -> String {
        return "f_id"
    }

    func encode(with coder: NSCoder) {
        //we are saving the name for the key "name"
        coder.encode(f_id, forKey: "f_id")
        coder.encode(f_title, forKey: "f_title")
        coder.encode(type, forKey: "type")
        if let moptions = _options
        {
            coder.encode(moptions, forKey: "options")
        }
        if let selOpt = _selectedOption
        {
            coder.encode(selOpt, forKey: "selectedOption")
        }
    }
    
    override init() {
     
    }
    
    required init(coder decoder: NSCoder) {
        //this retrieves our saved name object and casts it as a string
        if let nameObject = decoder.decodeObject(forKey: "f_id") as? String {
            _f_id = nameObject
        }
        
        if let nameObject = decoder.decodeObject(forKey: "f_title") as? String {
            _f_title = nameObject
        }
        
        if let nameObject = decoder.decodeObject(forKey: "type") as? String {
            _type = nameObject
        }
        
        if let nameObject = decoder.decodeObject(forKey: "options") as? [Option] {
            _options = nameObject
        }
        if let nameObject = decoder.decodeObject(forKey: "selectedOption") as? Option {
            _selectedOption = nameObject
        }
    }
    
    
    static func getAllFields() -> [Field]
    {
        var fields:[Field] = []
        let plistArr = Utility.getDictFrom(plstName: "asset_fields")
        for obj in plistArr
        {
            let objDict = obj as! NSMutableDictionary
            let field =  Field()
            field.f_id = objDict["id"] as! String
            field.f_title = objDict["title"] as! String
            field.type = objDict["type"] as! String
            field.options = [Option]()
            if let optionsArr = objDict["options"] as! [[String:String]]?
            {
                for optionObj in optionsArr
                {
                    let option = Option()
                    option.opt_id = optionObj["id"]!
                    option.opt_title = optionObj["title"]!
                    field.options.append(option)
                }
            }
            fields.append(field)
        }
        return fields
    }
}
