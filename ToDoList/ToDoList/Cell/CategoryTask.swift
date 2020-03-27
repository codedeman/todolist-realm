//
//  CategoryTask.swift
//  ToDoList
//
//  Created by Ominext on 3/24/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

class CategoryTask: UICollectionViewCell {

  @IBOutlet var iconCategory: UIImageView!
  
  @IBOutlet var taskNumber: UILabel!
  
  @IBOutlet var taskTitle: UILabel!
  
  func configureCell(){
    
  }
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
