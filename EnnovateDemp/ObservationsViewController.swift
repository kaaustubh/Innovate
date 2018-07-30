//
//  ObservationsViewController.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 29/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit
import DLRadioButton
import PopupDialog
import RSSelectionMenu

class ObservationsViewController: UIViewController {

    @IBOutlet weak var condition1Button: UIButton!
    @IBOutlet weak var radButton1: DLRadioButton!
    @IBOutlet weak var radButton2: DLRadioButton!
    @IBOutlet weak var radButton3: DLRadioButton!
    @IBOutlet weak var radButton4: DLRadioButton!
    @IBOutlet weak var otherTf: UITextField!
    @IBOutlet weak var tf1: UITextField!
    @IBOutlet weak var tf2: UITextField!
    @IBOutlet weak var tf3: UITextField!
    var asset: Asset!
    override func viewDidLoad() {
        super.viewDidLoad()
        setObservations()
        self.title = "Objservation"
        self.addBackbutton(title: "Back")
        // Do any additional setup after loading the view.
    }
    
    func goBack()
    {
        self.navigationController?.popViewController(animated: true)
    }

    func setObservations()
    {
        radButton1.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        radButton1.setTitle("Good", for: .normal)
        radButton1.setTitleColor(.black, for: .normal)
    
        radButton2.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        radButton2.setTitle("Needs service", for: .normal)
        radButton2.setTitleColor(.black, for: .normal)
    
        radButton3.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        radButton3.setTitle("Needs replacement", for: .normal)
        radButton3.setTitleColor(.black, for: .normal)
        
        radButton4.contentHorizontalAlignment = UIControlContentHorizontalAlignment.left
        radButton4.setTitle("Other", for: .normal)
        radButton4.setTitleColor(.black, for: .normal)
        
        radButton1.otherButtons = [radButton2, radButton3, radButton4]
        //radButton1.otherButtons[0].isSelected = true;
        guard let asset = self.asset else
        {
            return
        }
    
        if asset.conditon != nil
        {
            condition1Button.setTitle(asset.conditon, for: .normal)
        }
        otherTf.isEnabled = false
        if asset.fitting.count != 0
        {
            if Int(asset.fitting) == nil
            {
                radButton4.selected()
                
                otherTf.text = asset.fitting
                otherTf.isEnabled = true
            }
            else
            {
                otherTf.isEnabled = false
                switch(Int(asset.fitting))
                {
                    case 0: radButton1.selected()
                        break
                    case 1: radButton2.selected()
                        break
                    case 2: radButton3.selected()
                        break
                    default:
                        print("none")
                }
            }
        }
        
        tf1.text = asset.oldCoupn
        tf2.text = asset.newCoupn
        tf3.text = asset.obsrvn
    }
    
    @IBAction func radioButtonTapped(sender: DLRadioButton)
    {
        if sender.tag == 3
        {
            otherTf.isEnabled = true
        }
        else
        {
            otherTf.isEnabled = false
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func conditionButtonTapped()
    {
        let arr = ["Good", "Needs replacement", "Needs Service", "Other"]
        let selectionMenu =  RSSelectionMenu(dataSource: arr) { (cell, object, indexPath) in
            cell.textLabel?.text = arr[indexPath.row]
            cell.textLabel?.textColor = .black
            cell.tintColor = .orange
        }
        
        selectionMenu.show(style: .Formsheet, from: self)
        selectionMenu.onDismiss = {[weak self] selectedItems in
            guard  let weak = self else {
                return
            }
            self?.condition1Button.setTitle(selectedItems[0], for: .normal)
        }
    }
    
    @IBAction func saveButtonTapped()
    {
        asset.conditon = ""
        if let condition = condition1Button.title(for: .normal)
        {
            asset.conditon = condition
        }
        var fitting = ""
        if radButton1.isSelected
        {
            fitting = "0"
        }
        else if radButton2.isSelected
        {
            fitting = "1"
        }
        else if radButton3.isSelected {
            fitting = "2"
        }
        else
        {
            if let fittingT = otherTf.text
            {
                fitting = fittingT
            }
        }
        asset.fitting = fitting
        if let oldC = tf1.text
        {
            asset.oldCoupn = oldC
        }
        else
        {
            asset.oldCoupn = ""
        }
        
        if let oldC = tf2.text
        {
            asset.newCoupn = oldC
        }
        else
        {
            asset.newCoupn = ""
        }
        
        if let oldC = tf3.text
        {
            asset.obsrvn = oldC
        }
        else
        {
            asset.obsrvn = ""
        }
         DataStore.sharedInstnce.saveData(item: asset)
        let title = "Success"
        let message = "Details saved"
        let popup = PopupDialog(title: title, message: message, image: nil)
        let buttonOne = CancelButton(title: "Ok") { [weak self] in
            self!.navigationController?.popToViewController((self?.navigationController?.viewControllers[1])!, animated: true)
        }
        
        popup.addButtons([buttonOne])
        
        // Present dialog
        self.present(popup, animated: true, completion: nil)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    
    @objc func backButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func addBackbutton(title: String) {
        if let nav = self.navigationController,
            let item = nav.navigationBar.topItem {
            item.backBarButtonItem  = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action:
                #selector(self.backButtonAction))
        } else {
            if let nav = self.navigationController,
                let _ = nav.navigationBar.backItem {
                self.navigationController!.navigationBar.backItem!.title = title
            }
        }
    }
}
