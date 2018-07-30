//
//  TextFieldCell.swift
//  EnnovateDemp
//
//  Created by Kaustubh on 25/07/18.
//  Copyright © 2018 KaustubhtestApp. All rights reserved.
//

import UIKit

class TextFieldCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var titleTextLabel: UILabel!
    @IBOutlet weak var valueButton: UITextField!
    private var _title = ""
    private var _value = ""
    var _id = ""
    weak var delegate :DropDownDelegate?
    
    var title: String {
        get {
            return _title
        }
        set(title) {
            titleTextLabel.text = title
            _title = title
        }
    }
    
    var value: String {
        get {
            return _value
        }
        set(value) {
            valueButton.text = value
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        valueButton.resignFirstResponder()
        let selectedField = Field()
        selectedField.f_id = _id
        selectedField.type = "1"
        selectedField.f_title = _title
        var option = Option()
        option.opt_title = valueButton.text!
        selectedField.selectedOption = option
        delegate?.setField(field: selectedField)
        return true
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
