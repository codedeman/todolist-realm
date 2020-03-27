//
//  TaskTableViewCell.swift
//  ToDoList
//
//  Created by Ominext on 3/26/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

class TaskTableViewCell: UITableViewCell {

  let checkedImage = UIImage(named: "check.png")! as UIImage
  let uncheckedImage = UIImage(named: "uncheck.png")! as UIImage
  
  // Bool property
 
  @IBOutlet var imageCheckBox: CheckBoxButton!
  
  @IBOutlet var titleLabel: UILabel!
  var tab = 0
  @IBOutlet var timeLabel: UILabel!
  
  
  var isChecked: Bool = false {
    didSet{
      if isChecked == true {
        imageCheckBox.setImage(checkedImage, for: .normal)
      } else {
        imageCheckBox.setImage(uncheckedImage, for: .normal)
      }
    }
  }
  
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    imageCheckBox.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
//    imageCheckBox.addTarget(self, action: #selector(checkBoxbtnWasPressed), for: .touchDown)
//    imageCheckBox.number
    }
  
  @objc func buttonClicked() {
//    if sender == self {
      if isChecked == true {
        isChecked = false
      } else {
        isChecked = true
      }
//    }
  }
  

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
