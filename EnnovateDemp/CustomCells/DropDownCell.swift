//
//  DropDownCell.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 25/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {

    private var _field_title = ""
    private var _value = ""
    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var valueButton: UIButton!
    weak var delegate: DropDownDelegate?
    var f_id = ""
    
    public var field_title: String {
        get {
            return _field_title
        }
        set(field_title) {
            _field_title = field_title
            titleTextLabel.text = field_title
        }
    }
    
    var value: String {
        get {
            return _value
        }
        set(value) {
            _value = value
            valueButton.setTitle(value, for: UIControlState.normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    @IBAction func dropdownTapped(sender: UIButton)
    {
        guard let _delegate = delegate else {
            return
        }
        _delegate.dropDownTapped(index: Int(f_id)!)
    }

}
