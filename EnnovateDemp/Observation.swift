//
//  Observation.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 23/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation

class Observation: NSObject {
    var obs_id: String = ""
    var obs_title: String = ""
    var type: String = ""
    var options: [Option]?
    
    static func getAllFields() -> [Observation]
    {
        let fields = [Observation]()
        let plistArr = Utility.getDictFrom(plstName: "observations")
        var field: Observation
        for obj in plistArr
        {
            let objDict = obj as! NSMutableDictionary
            field =  Observation()
            field.obs_id = objDict["id"] as! String
            field.obs_title = objDict["title"] as! String
            field.type = objDict["type"] as! String
            field.options = [Option]()
            var option: Option
            if let optionsArr = objDict["options"] as! [[String:String]]?
            {
                for optionObj in optionsArr
                {
                    
                    option = Option()
                    option.opt_id = optionObj["title"]!
                    option.opt_title = optionObj["id"]!
                    field.options?.append(option)
                }
            }
        }
        return fields
    }

}
