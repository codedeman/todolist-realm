//
//  ToDoListItem.swift
//  ToDoList
//
//  Created by Ominext on 3/24/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import Foundation
import RealmSwift

class ToDoListItem: Object {
  @objc dynamic var name = ""
  @objc dynamic var done = false
}
