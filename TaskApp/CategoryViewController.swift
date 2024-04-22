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

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var categoryName: UITextField!
    @IBOutlet weak var categoryTableView: UITableView!
    
    let realm = try! Realm()
    var category: Category! = Category()
    
    var categoryArray = try! Realm().objects(Category.self)
        
    weak var delegate: CategoryViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        categoryTableView.fillerRowHeight = UITableView.automaticDimension
        categoryTableView.delegate = self
        categoryTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let result = categoryArray.first{
//            print(result)
//        }
        categoryTableView.reloadData()
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let catName = self.categoryName.text{
            let catIdArray = try! Realm().objects(Category.self).where({$0.categoryName == catName}).map{$0.id}
            if catIdArray.count < 1 {
                try! realm.write {
                    print(catName)
                    let catNames = Category()
                    catNames.categoryName = catName
                    self.realm.add(catNames)
                    print(self.category.categoryName)
                }
            }
        }

        navigationController?.popViewController(animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用可能な cell を得る
        let cell_cat = tableView.dequeueReusableCell(withIdentifier: "Cell_cat", for: indexPath)
        // Cellに値を設定する
        let category = categoryArray[indexPath.row]
        var content = cell_cat.defaultContentConfiguration()
        content.text = category.categoryName
        cell_cat.contentConfiguration = content
        
        return cell_cat
    }
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    // セルが削除が可能なことを伝えるメソッド
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath)-> UITableViewCell.EditingStyle {
        return .delete
    }
    // Delete ボタンが押された時に呼ばれるメソッド
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // 削除するタスクを取得する
            let category = self.categoryArray[indexPath.row]

            // データベースから削除する
            try! realm.write {
                self.realm.delete(category)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
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
