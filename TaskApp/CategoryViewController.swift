//
//  CategoryViewController.swift
//  TaskApp
//
//  Created by 中村 行汰 on 2024/04/16.
//

import UIKit
import RealmSwift

protocol CategoryViewControllerDelegate: AnyObject{
    func receiveId(_ id: String)
    func receiveName(_ name: String)
}

class CategoryViewController: UIViewController {
    @IBOutlet weak var categoryId: UITextField!
    @IBOutlet weak var categoryName: UITextField!
    
    let realm = try! Realm()
    var task: Task!
    
    weak var delegate: CategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let category = task.category {
            categoryId.text = category.id
            categoryName.text = category.categoryName
        }
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let id = categoryId.text {
            //print(id)
            delegate?.receiveId(id)
        }
        if let name = categoryName.text {
            //print(name)
            delegate?.receiveName(name)
        }
        navigationController?.popViewController(animated: true)
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
