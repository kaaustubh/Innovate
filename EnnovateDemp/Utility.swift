//
//  Utility.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 23/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation

class Utility: NSObject
{
    static func getDictFrom(plstName: String) -> NSMutableArray
    {
        var myDict: NSMutableArray = NSMutableArray()
        if let path = Bundle.main.path(forResource: plstName, ofType: "plist") {
            myDict = NSMutableArray(contentsOfFile: path)!// as? [NSDictionary]
        }
        return myDict
    }
}
