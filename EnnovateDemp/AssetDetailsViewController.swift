//
//  AssetDetailsViewController.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 24/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit
import RSSelectionMenu

protocol DropDownDelegate: class {
    func dropDownTapped(index: Int)
    func setField(field: Field)
}

class AssetDetailsViewController: UIViewController, DropDownDelegate {
    
    var asset: Asset!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Asset Details"
        if asset == nil
        {
            asset = Asset()
            asset.asset_id = String(Int(arc4random_uniform(1000) + 1))
            asset.selectedFields = [Field]()
        }
        self.addBackbutton(title: "Back")
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func nextButtontapped()
    {
        self.performSegue(withIdentifier: "observation", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "observation"){
            var controllerB = segue.destination as! ObservationsViewController
            controllerB.asset = self.asset
        }
    }

}

extension AssetDetailsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return Field.getAllFields().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        var isSelectedField = false
        var field = Field.getAllFields()[indexPath.row]
        if let i = asset.selectedFields.index(where: { $0.f_id == String(indexPath.row) }) {
            field = asset.selectedFields[i]
            isSelectedField = true
        }
        
        if Int(field.type) == 0
        {
            let tableViewCell =  tableView.dequeueReusableCell(withIdentifier: "DropDownCell", for: indexPath)
                as! DropDownCell
            tableViewCell.delegate = self
            tableViewCell.field_title = field.f_title
            tableViewCell.f_id = field.f_id
            if isSelectedField
            {
                tableViewCell.value = (field.selectedOption.opt_title)
            }
            else
            {
                tableViewCell.value = ""
            }
            return tableViewCell
        }
        else
        {
            let tableViewCell = tableView.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath)
                as! TextFieldCell
            tableViewCell.title = field.f_title
            tableViewCell._id = field.f_id
            tableViewCell.delegate = self
            if isSelectedField
            {
                tableViewCell.value = (field.selectedOption.opt_title)
            }
            else
            {
                tableViewCell.value = ""
            }
            return tableViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
    }
    func dropDownTapped(index: Int)
    {
        let field = Field.getAllFields()[index]
        let selectionMenu =  RSSelectionMenu(dataSource: field.options) { (cell, object, indexPath) in
            cell.textLabel?.text = field.options[indexPath.row].opt_title
            cell.textLabel?.textColor = .black
            // Change tint color (if needed)
            cell.tintColor = .orange
        }
    
        selectionMenu.show(style: .Formsheet, from: self)
        selectionMenu.onDismiss = {[weak self] selectedItems in
            guard  let weak = self else {
                return
            }
            if selectedItems.count > 0
            {

                if let i = weak.asset.selectedFields.index(where: { $0.f_id == field.f_id }) {
                    let prevField = weak.asset.selectedFields[i]
                    prevField.selectedOption = selectedItems[0]
                }
                else
                {
                    let selectedField = Field()
                    selectedField.f_id = field.f_id
                    selectedField.type = field.type
                    selectedField.f_title =  field.f_title
                    selectedField.selectedOption = selectedItems[0]
                    weak.asset.selectedFields.append(selectedField)
                }
                weak.tableView.reloadData()
            }
        }
    }
    
    func setField(field: Field)
    {
        if let i = self.asset.selectedFields.index(where: { $0.f_id == field.f_id }) {
            let prevField = self.asset.selectedFields[i]
                prevField.selectedOption = field.selectedOption
        }
        else
        {
            self.asset.selectedFields.append(field)
        }
        self.tableView.reloadData()
    }
}
