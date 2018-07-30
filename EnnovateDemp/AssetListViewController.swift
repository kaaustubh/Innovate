//
//  AssetListViewController.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 24/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit

class AssetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        self.title = "Saved Assets"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginButtonClicked(sender: UIButton)
    {
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "AssetDetails") as! AssetDetailsViewController
        self.navigationController?.pushViewController(newViewController, animated: true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let assests = DataStore.sharedInstnce.getData()
        if assests == nil{
            return 0
        }
        return assests!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let assests = DataStore.sharedInstnce.getData()
        let tableViewCell =  UITableViewCell(style: .default, reuseIdentifier: "cellId")
        var text = ""
        if assests != nil
        {
            text = "Asset no- " + assests![indexPath.row].asset_id
        }
        tableViewCell.textLabel?.text = text
        return tableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let assests = DataStore.sharedInstnce.getData()
        if assests != nil
        {
            let asset = assests![indexPath.row]
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AssetDetails") as! AssetDetailsViewController
            newViewController.asset = asset
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
}
