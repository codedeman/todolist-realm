//
//  PopupSelectDate.swift
//  ToDoList
//
//  Created by Ominext on 3/26/20.
//  Copyright © 2020 Ominext. All rights reserved.
//

import UIKit

class PopupSelectDate: UIViewController {

  @IBOutlet var backgroundView: UIView!
  @IBOutlet var saveButton: UIButton!
  @IBOutlet var cancelButton: UIButton!
  override func viewDidLoad() {
        super.viewDidLoad()
    
    cancelButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
    cancelButton.layer.borderWidth = 0.3
    saveButton.layer.borderWidth = 0.5
    saveButton.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)

    
//    backgroundView.backgroundColor = .clear
      let tap = UITapGestureRecognizer(target: self, action: #selector(backWasPressed))
      tap.numberOfTapsRequired = 1
      backgroundView.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }
  
  
  @objc func backWasPressed()  {
    
      dismiss(animated: true, completion: nil)
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
