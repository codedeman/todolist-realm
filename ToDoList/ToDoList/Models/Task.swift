//
//  Task.swift
//  ToDoList
//
//  Created by Ominext on 3/25/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import Foundation
import RealmSwift
enum WorkType:Int{
  
  case work
  case personal
  
  
}

enum Priority: Int {
  case high
  case medium
  case low
}
class Task: Object {
  @objc dynamic var title = ""
  @objc dynamic var notes = ""
  @objc dynamic var date = ""
  @objc dynamic var done = false
  
  
  

}
