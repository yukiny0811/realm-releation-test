//
//  FirstTableViewController.swift
//  TodoRealm
//
//  Created by クワシマ・ユウキ on 2021/05/29.
//  Copyright © 2021 クワシマ・ユウキ. All rights reserved.
//

import UIKit
import RealmSwift

class FirstTableViewController: UITableViewController {
    
    private var realm: Realm!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        realm = try! Realm()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let objs: Results<Parent> = realm.objects(Parent.self)
        return objs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellFirst", for: indexPath)
        let objs: Results<Parent> = realm.objects(Parent.self)
        cell.textLabel?.text = objs[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let obj = realm.objects(Parent.self)[indexPath.row]
            try! realm.write(){
                realm.delete(obj)
            }
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let nextView = storyboard.instantiateViewController(withIdentifier: "secondVC") as! SecondTableViewController
        nextView.index = indexPath.row
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    @IBAction func add() {
        let parent = Parent()
        parent.title = randomString()
        try! realm.write(){
            realm.add(parent)
        }
        self.tableView.reloadData()
    }
    
    //ただランダムな文字列作ってるだけです
    func randomString() -> String {
      let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<12).map{ _ in characters.randomElement()! })
    }

}
