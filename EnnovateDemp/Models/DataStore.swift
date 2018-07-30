//
//  DataStore.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 29/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import Foundation
class DataStore {
    static let sharedInstnce = DataStore()
    private init() {}
    var filePath: String {
        //1 - manager lets you examine contents of a files and folders in your app; creates a directory to where we are saving it
        let manager = FileManager.default
        //2 - this returns an array of urls from our documentDirectory and we take the first path
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        print("this is the url path in the documentDirectory \(url)")
        //3 - creates a new path component and creates a new file called "Data" which is where we will store our Data array.
        return (url!.appendingPathComponent("Data").path)
    }
    var assets: [Asset] = []
    func saveData(item: Asset)
    {
        if getData() != nil
        {
            assets = getData()
        }
        
        if let fooOffset = assets.index(where: {$0.asset_id == item.asset_id}) {
            assets[fooOffset] = item
        } else {
            assets.append(item)
        }
        NSKeyedArchiver.archiveRootObject(assets, toFile: filePath)
    }
    
    func getData() -> [Asset]!
    {
        guard let books = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Asset] else { return nil }
        return books
    }
    
}
