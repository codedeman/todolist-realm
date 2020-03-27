//
//  HomeVC.swift
//  ToDoList
//
//  Created by Ominext on 3/24/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit
import SnapKit
import RealmSwift

class HomeVC: UIViewController {
  var realm: Realm!
  let imageArr = ["allicon.png","workIcon.png"]
  let greetingLabel:UILabel = {
    
    let label = UILabel()
    
    label.tintColor = .white
    label.textColor =  .white
    label.text = "Hello Kevin!"
    label.font = UIFont.boldSystemFont(ofSize: 30)
    return label
  }()
  let taskLabel:UILabel = {
    let label = UILabel()
    
    label.tintColor = .white
    label.textColor =  .white
    label.font = UIFont.italicSystemFont(ofSize: 15)
    return label
    
  }()
  let newTaskButton:UIButton = {
    
    let button = UIButton()
    
    return button
    
  }()
  var  str = "2020-03-26 14:42:12 at 2:44PM"

  var categoryTask:UICollectionView!
  var gradientLayer: CAGradientLayer!
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
//      str = String(str.prefix(upTo: "at"))
      
      let width = self.view.frame.width
      let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: width, height: 44))
      self.view.addSubview(navigationBar);
      let navigationItem = UINavigationItem(title: "Navigation bar")
      navigationBar.setItems([navigationItem], animated: false)
      createGradientLayer()
      createUI()
      categoryTask.layer.cornerRadius = 30
     
      categoryTask.register(UINib(nibName: "CategoryTask", bundle: nil), forCellWithReuseIdentifier: "CategoryTask")

      categoryTask.delegate = self
      categoryTask.dataSource = self
      
     

        // Do any additional setup after loading the view.
    }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: animated)

    realm = try! Realm()
    let task = realm.objects(Task.self)
    DispatchQueue.main.async {
      self.taskLabel.text = "You have \(task.count) tasks scheduled today"
      self.categoryTask.reloadData()
    }
    
  }
  
  func createGradientLayer() {
    gradientLayer = CAGradientLayer()

    gradientLayer.frame = self.view.bounds
    
    gradientLayer.colors = [UIColor.purple.cgColor, UIColor.gray.cgColor]
    
    self.view.layer.addSublayer(gradientLayer)
  }

  func createUI()  {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 10, left: 30, bottom: 10, right: 30)
    layout.itemSize = CGSize(width: 150, height: 150)
    layout.scrollDirection = .vertical
    categoryTask = UICollectionView(frame:CGRect.init(), collectionViewLayout: layout)
    categoryTask.backgroundColor = .white
    self.view.addSubview(greetingLabel)
    self.view.addSubview(taskLabel)
    self.view.addSubview(categoryTask)
    
//    categoryTask.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
    
    
    greetingLabel.snp.makeConstraints { (make) in
      make.trailing.equalTo(self.view)
      make.leading.equalTo(self.view).inset(30)
      make.top.equalTo(self.view).inset(100)
      
    }
    
    taskLabel.snp.makeConstraints { (make) in
      make.trailing.equalTo(self.view)
      make.leading.equalTo(self.view).inset(30)
      make.top.equalTo(self.greetingLabel).inset(50)
      
    }
    categoryTask.snp.makeConstraints { (make) in
      make.bottom.equalTo(self.view).inset(0)
      make.leading.equalTo(self.view).inset(0)
      make.trailing.equalTo(self.view).inset(0)
      make.top.equalTo(taskLabel).inset(150)
      
    }
    
    
  }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: UICollectionView

extension HomeVC:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 2
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
      let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryTask", for: indexPath) as? CategoryTask
    
      realm = try! Realm()
    
      let task = realm.objects(Task.self)
      cell?.iconCategory.image = UIImage(named: imageArr[indexPath.row])
      cell?.taskNumber.text = String(task.count)
      cell?.layer.cornerRadius = 10
      cell?.backgroundColor = #colorLiteral(red: 0.8145137613, green: 0.8776412482, blue: 1, alpha: 1)
    
    
    return cell!
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    navigationController?.present(MainViewController(), animated: true, completion: nil)
      navigationController?.pushViewController(MainViewController(), animated: true)
    
//    present(MainViewController(), animated: true, completion: nil)
  }
  
  
  
}
// MARK UICollectionViewDataSource

extension HomeVC:UICollectionViewDelegate{
  
  
}
