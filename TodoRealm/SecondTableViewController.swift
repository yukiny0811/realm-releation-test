//
//  SecondTableViewController.swift
//  TodoRealm
//
//  Created by クワシマ・ユウキ on 2021/05/29.
//  Copyright © 2021 クワシマ・ユウキ. All rights reserved.
//

import UIKit
import RealmSwift

class SecondTableViewController: UITableViewController {
    
    var index: Int?

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
        let children = objs[index!].children
        return children.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellSecond", for: indexPath)
        let objs: Results<Parent> = realm.objects(Parent.self)
        let children = objs[index!].children
        cell.textLabel?.text = children[indexPath.row].title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let parent = realm.objects(Parent.self)[index!]
            let children = parent.children
            let obj = children[indexPath.row]
            try! realm.write(){
                realm.delete(obj)
            }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func add() {
        let objs: Results<Parent> = realm.objects(Parent.self)
        let parent = objs[index!]
        let children = parent.children
        let child = Child()
        child.title = randomString()
        try! realm.write(){
            children.append(child)
        }
        self.tableView.reloadData()
    }
    
    //ただランダムな文字列作ってるだけです
    func randomString() -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<12).map{ _ in characters.randomElement()! })
    }

}
