//
//  ViewController.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 22/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import PopupDialog
class ViewController: UIViewController {

    @IBOutlet weak var username: SkyFloatingLabelTextField!
    @IBOutlet weak var password: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        self.hideKeyboardWhenTappedAround()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func setupUI() {
        let lightGreyColor = UIColor(red: 197/255, green: 205/255, blue: 205/255, alpha: 1.0)
        let darkGreyColor = UIColor(red: 52/255, green: 42/255, blue: 61/255, alpha: 1.0)
        let overcastBlueColor = UIColor(red: 0, green: 187/255, blue: 204/255, alpha: 1.0)
        
        username.placeholder = "Enter the username"
        username.title = "Username"
        
        
        password.placeholder = "Enter the password"
        password.title = "Password"
        
        password.tintColor = overcastBlueColor // the color of the blinking cursor
        password.textColor = darkGreyColor
        password.lineColor = lightGreyColor
        password.titleColor = overcastBlueColor
        password.placeholderColor = lightGreyColor
        password.selectedTitleColor = overcastBlueColor
        password.selectedLineColor = overcastBlueColor
        
        password.lineHeight = 1.0 // bottom line height in points
        password.selectedLineHeight = 2.0
        password.isSecureTextEntry = true
        
        username.tintColor = overcastBlueColor // the color of the blinking cursor
        username.textColor = darkGreyColor
        username.placeholderColor = lightGreyColor
        username.titleColor = overcastBlueColor
        username.lineColor = lightGreyColor
        username.selectedTitleColor = overcastBlueColor
        username.selectedLineColor = overcastBlueColor
        
        username.lineHeight = 1.0 // bottom line height in points
        username.selectedLineHeight = 2.0
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginButtonClicked(sender: UIButton) {
        if username.text  == "admin" && password.text == "password"
        {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "AssetView") as! AssetListViewController
            self.navigationController?.pushViewController(newViewController, animated: true)
        }
        else
        {
            let title = "Error"
            let message = "Invalid login credentials, please contact the admin"
            let popup = PopupDialog(title: title, message: message, image: nil)
            let buttonOne = CancelButton(title: "Ok") { 
            }
            
            popup.addButtons([buttonOne])
            
            // Present dialog
            self.present(popup, animated: true, completion: nil)
        }
    }

}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

