//
//  CheckBoxButton.swift
//  ToDoList
//
//  Created by Ominext on 3/26/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import Foundation
import UIKit

class CheckBoxButton: UIButton {
  
  // Images
  let checkedImage = UIImage(named: "check.png")! as UIImage
  let uncheckedImage = UIImage(named: "uncheck.png")! as UIImage
  
  // Bool property
  var isChecked: Bool = false {
    didSet{
      if isChecked == true {
        self.setImage(checkedImage, for: .normal)
      } else {
        self.setImage(uncheckedImage, for: .normal)
      }
    }
  }
  
  override func awakeFromNib() {
    self.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    self.isChecked = false
  }
  
 @objc func buttonClicked(sender: UIButton) {
    if sender == self {
      if isChecked == true {
        isChecked = false
      } else {
        isChecked = true
      }
    }
  }
  
}
