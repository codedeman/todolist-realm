//
//  CreateNewTask.swift
//  ToDoList
//
//  Created by Ominext on 3/25/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift
class CreateNewTask: UIViewController {
  var gradientLayer: CAGradientLayer!
  var realm: Realm!
  var dateIsOn:Int! = 0

  let titleLabel:UILabel = {
    let label  = UILabel()
    label.tintColor = .white
    label.textColor = .white
    label.text = "New To Do"
    label.font = UIFont.boldSystemFont(ofSize: 30)
    return label
  }()
  
  
  let backBtn:UIButton = {
    let button = UIButton()
    button.tintColor = .white
    button.setImage(UIImage(named: "back.png"), for: .normal)
    return button
    
  }()
  
  
  let titleTextField: UITextField = {
    let text =  UITextField()
    text.placeholder = "Title"
    return text
  }()
  
  let notesTextField:UITextField = {
    let text = UITextField()
    text.placeholder = "Notes"
    return text
  }()
  let mainView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
    
    return view
  }()
  let setDateLabel:UILabel = {
    let label = UILabel()
    label.text = "Set Date"
    label.font = UIFont.boldSystemFont(ofSize: 15)
    return label
    
  }()
  let switchDate:UISwitch = {
    let switchBtn = UISwitch()
    return switchBtn
  }()
  
  let dateDisplayLabel:UILabel = {
    
    let label = UILabel()
    return label
    
  }()
  
  let alamLabel:UILabel = {
    let label = UILabel()
    label.text = "Alarm"
    return label
    
  }()
  
  let createBtn:UIButton = {
    
    let button = UIButton()
    button.setTitle("Create", for: .normal)
    button.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    button.layer.cornerRadius = 20
    return button
    
  }()
  
  let alarmButton:UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "alarm.png"), for: .normal)
    return button
  }()
  
  let flag1 = UIImage(named: "flag3.png")
  let flag2 = UIImage(named: "flag1.png")
  let flag0 = UIImage(named: "flag0.png")
  
  let grayView:UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return view
    
  }()
  
  let priorityLabel:UILabel = {
  
    let label = UILabel()
    
    label.text = "Priority"
    return label
  }()
  
  let grayView2:UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return view
    
  }()
  
  let priorityButton:UIButton = {
    let button = UIButton()
    button.setImage(UIImage(named: "flag0.png"), for: .normal)
    return button
  }()
  override func viewDidLoad() {
        super.viewDidLoad()
    initUI()
    realm = try! Realm()
    
    priorityButton.addTarget(self, action: #selector(priorityButtonWasPressed), for: .touchUpInside)
    
    switchDate.addTarget(self, action: #selector(didTabDate), for: .allEvents)
    backBtn.addTarget(self, action: #selector(backButtonWasPressed), for: .allEvents)
    createBtn.addTarget(self, action: #selector(createBtnWasPressed), for: .touchDown)
    alarmButton.addTarget(self, action: #selector(selectDateWasPressed), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
  
  @objc func selectDateWasPressed(){
    
    let popupVC = PopupSelectDate()
    popupVC.modalPresentationStyle = .overCurrentContext
    navigationController?.present(popupVC, animated: true, completion: nil)
  }
  
  @objc func priorityButtonWasPressed(){
    let optionMenu = UIAlertController(title: nil, message: "Choose Option", preferredStyle: .actionSheet)
    // 2
    let priority1 = UIAlertAction(title: "Priority 1", style: .default) { (event) in
      self.priorityButton.setImage(self.flag1, for: .normal)
    }
    priority1.setValue(flag1?.withRenderingMode(.alwaysOriginal), forKey: "image")
    let priority2 = UIAlertAction(title: "Priority 2", style: .default) { (event) in
      
      self.priorityButton.setImage(self.flag2, for: .normal)
      
    }
  priority2.setValue(flag2?.withRenderingMode(.alwaysOriginal), forKey: "image")
    // 3
    let priority3 = UIAlertAction(title: "Priority 3" , style: .default) { (event) in
      
      self.priorityButton.setImage(self.flag0, for: .normal)
      
    }
  priority3.setValue(flag0?.withRenderingMode(.alwaysOriginal), forKey: "image")
    
        // 4
    optionMenu.addAction(priority1)
    optionMenu.addAction(priority2)
    optionMenu.addAction(priority3)
    
    // 5
    self.present(optionMenu, animated: true, completion: nil)
    
  }
  

  @objc func createBtnWasPressed(){
    let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)

    guard let title = titleTextField.text else {
      return
    }
    
    guard let note = notesTextField.text else {
      return
    }
    let newTask = Task()
    if dateIsOn == 1{
      newTask.date = timestamp
            newTask.title = title
            newTask.notes = note
            newTask.done = false
      
    }else{
      newTask.date = ""
      newTask.title = title
      newTask.notes = note
      newTask.done = false
    }

    try! realm.write({
      self.realm.add(newTask)
    })
    
    
    DispatchQueue.main.async {
      self.navigationController?.popViewController(animated: true)
    }
    

  }
  @objc  func didTabDate(){
    
    if switchDate.isOn{
      let timestamp = DateFormatter.localizedString(from: Date(), dateStyle: .medium, timeStyle: .short)
      DispatchQueue.main.async {
        self.dateIsOn = 1
        self.dateDisplayLabel.text  = "\(timestamp)"
      }
    }else{
      DispatchQueue.main.async {
         self.dateIsOn = 0
        self.dateDisplayLabel.text  = ""
      }
      
    }
   
    
    
    
    
  }
  
  func initUI()  {
    self.view.addSubview(titleLabel)
    self.view.addSubview(backBtn)
    self.view.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    mainView.addSubview(titleTextField)
    mainView.addSubview(notesTextField)
    mainView.layer.cornerRadius = 20
    mainView.addSubview(setDateLabel)
    mainView.addSubview(switchDate)
    mainView.addSubview(dateDisplayLabel)
    self.view.addSubview(mainView)
    mainView.addSubview(createBtn)
    mainView.addSubview(alamLabel)
    mainView.addSubview(grayView)
    mainView.addSubview(priorityLabel)
    mainView.addSubview(grayView2)
    mainView.addSubview(priorityButton)
    mainView.addSubview(alarmButton)
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
      make.leading.equalTo(self.view).inset(0)
      make.trailing.equalTo(self.view).inset(0)
      make.top.equalTo(titleLabel).inset(100)
      make.bottom.equalTo(self.view).inset(-1)
    }
    titleTextField.snp.makeConstraints { (make) in
      make.top.equalTo(self.mainView).inset(50)
      make.leading.equalTo(self.mainView).inset(10)
      make.trailing.equalTo(self.mainView).inset(10)
    }

    notesTextField.snp.makeConstraints { (make) in
      make.top.equalTo(self.titleTextField).inset(50)
      make.leading.equalTo(self.mainView).inset(10)
      make.trailing.equalTo(self.mainView).inset(10)
    }
    
    setDateLabel.snp.makeConstraints { (make) in
      make.top.equalTo(notesTextField).inset(50)
      make.leading.equalTo(self.mainView).inset(10)
    }
    
    switchDate.snp.makeConstraints { (make) in
      
      make.top.equalTo(notesTextField).inset(50)
      make.trailing.equalTo(self.mainView).inset(10)
    }
//    dateDisplayLabel.snp.makeConstraints { (make) in
//
//      make.top.equalTo(switchDate).inset(50)
//      make.trailing.equalTo(self.mainView).inset(10)
//    }
    
    alamLabel.snp.makeConstraints { (make) in
      
      make.top.equalTo(setDateLabel).inset(50)
      make.leading.equalTo(mainView).inset(10)
    }
    
    alarmButton.snp.makeConstraints { (make) in
      
      make.top.equalTo(switchDate).inset(50)
      make.trailing.equalTo(self.mainView).inset(10)
      make.height.width.equalTo(40)

    }
    
    createBtn.snp.makeConstraints { (make) in
      
      make.bottom.equalTo(self.mainView).inset(80)
      make.leading.equalTo(self.mainView).inset(30)
      make.height.equalTo(50)
      make.trailing.equalTo(self.mainView).inset(30)

    }
    
    grayView.snp.makeConstraints { (make) in
      make.top.equalTo(alamLabel).inset(40)
      make.leading.equalTo(self.mainView).inset(10)
      make.trailing.equalTo(self.mainView).inset(10)
      make.height.equalTo(1)
    }
    
    priorityLabel.snp.makeConstraints { (make) in
      
      make.top.equalTo(grayView).inset(50)
      make.leading.equalTo(mainView).inset(10)
    }
    
    priorityButton.snp.makeConstraints { (make) in
      
      make.top.equalTo(self.grayView).inset(50)
      make.trailing.equalTo(self.mainView).inset(10)
      make.height.width.equalTo(30)
    }
    
    
   
    
  }


  @objc func backButtonWasPressed(_ sender: Any) {
    navigationController?.popViewController(animated: true)
  }
  
  func createGradientLayer() {
    gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.view.bounds
    gradientLayer.colors = [UIColor.purple.cgColor, UIColor.gray.cgColor]
    
    self.view.layer.addSublayer(gradientLayer)
  }


}
