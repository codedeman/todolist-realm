//
//  MainViewController.swift
//  ToDoList
//
//  Created by Ominext on 3/24/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit
import RealmSwift
import SnapKit
import JJFloatingActionButton

class MainViewController: UIViewController {
  let actionButton = JJFloatingActionButton()
  var gradientLayer: CAGradientLayer!

  let titleLabel:UILabel = {
    let label  = UILabel()
    label.tintColor = .white
    label.textColor = .white
    label.text = "All To Do"
    label.font = UIFont.boldSystemFont(ofSize: 30)
    return label
  }()
  
  let mainView:UIView = {
    
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    return view
  }()
  
  let backBtn:UIButton = {
    let button = UIButton()
    button.tintColor = .white
    button.setImage(UIImage(named: "back.png"), for: .normal)
    return button
    
  }()
  
  let prioritySegmentedControl:UISegmentedControl = {
    
    let segmentControl = UISegmentedControl()
    return segmentControl
  }()
  
  var taskTable = UITableView()
    var realm: Realm!
  
    var toDoList: Results<Task>{
      get {
        return realm.objects(Task.self)
      }
    }
  
  

  
    override func viewDidLoad() {
        super.viewDidLoad()
      self.createGradientLayer()
      self.backBtn.addTarget(self, action: #selector(self.backBtnWasPressed), for: .touchDown)
      
      actionButton.addItem(title: "item 1", image: UIImage(named: "First")?.withRenderingMode(.alwaysTemplate)) { item in
       self.navigationController?.pushViewController(CreateNewTask(), animated: true)
      }
      
      realm = try! Realm()
      taskTable.delegate = self
      taskTable.dataSource = self
      taskTable.register(UINib(nibName: "TaskTableViewCell" , bundle: .main), forCellReuseIdentifier: "TaskTableViewCell")
      initUI()

    }
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    taskTable.reloadData()
  }
  func createGradientLayer() {
    gradientLayer = CAGradientLayer()
    
    gradientLayer.frame = self.view.bounds
    
    gradientLayer.colors = [UIColor.purple.cgColor, UIColor.gray.cgColor]
    
    self.view.layer.addSublayer(gradientLayer)
  }
  

  
 @objc func backBtnWasPressed()  {
    
    navigationController?.popViewController(animated: true)
  }
  private func initUI(){
    
    self.view.addSubview(titleLabel)
    self.view.addSubview(mainView)
    self.view.backgroundColor = .white
    self.view.addSubview(backBtn)
    self.mainView.addSubview(prioritySegmentedControl)
    taskTable.layer.cornerRadius = 10
    
    mainView.layer.cornerRadius = 20
    mainView.addSubview(taskTable)
    mainView.addSubview(actionButton)
    backBtn.snp.makeConstraints { (make) in
      make.leading.equalTo(self.view).inset(30)
      make.top.equalTo(self.view).inset(100)
    }
    titleLabel.snp.makeConstraints { (make) in
      make.leading.equalTo(self.view).inset(30)
      make.top.equalTo(self.backBtn).inset(50)
      make.trailing.equalTo(self.view)
 
      
    }
    
    mainView.snp.makeConstraints { (make) in
      make.top.equalTo(self.titleLabel).inset(150)
            make.leading.equalTo(self.view).inset(0)
            make.trailing.equalTo(self.view).inset(0)
      make.bottom.equalTo(self.view).inset(0)
    }
    
    prioritySegmentedControl.snp.makeConstraints { (make) in
      make.top.equalTo(self.mainView).inset(0)
      make.leading.equalTo(self.mainView).inset(0)
      make.trailing.equalTo(self.mainView).inset(0)
    }
    
    taskTable.snp.makeConstraints { (make) in

      make.top.equalTo(prioritySegmentedControl).inset(10)
      make.leading.equalTo(self.mainView).inset(10)
      make.trailing.equalTo(self.mainView).inset(10)
      make.height.equalTo(350)
    }
    
    actionButton.snp.makeConstraints { (make) in
        make.trailing.equalTo(self.mainView).inset(30)
        make.bottom.equalTo(self.mainView).inset(20)
    }
  
  

  }
  
}



extension MainViewController:UITableViewDataSource{
  
   func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
    if (editingStyle == .delete) {
      let item = toDoList[indexPath.row]
      
      try! self.realm.write ({
        self.realm.delete(item)
      })
      
      tableView.deleteRows(at: [indexPath], with: .automatic)
    }
  }
  
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell else {return}
    
    
  
  }
  
  // MARK: - Table view data source
  
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return toDoList.count
  }
  
   func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return true
  }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as? TaskTableViewCell
    let item = toDoList[indexPath.row]
    cell?.titleLabel.text = item.title
    let dateString = item.date.split(separator: "A")
    cell?.timeLabel.text =  item.date
    cell?.backgroundColor = .clear
    
    //Ternary operator....basically an if else statement on one line
//    cell!.accessoryType = item.done == true ? .checkmark : .none
    
    return cell!
  }
  
}


extension MainViewController:UITableViewDelegate {
  
  
}



