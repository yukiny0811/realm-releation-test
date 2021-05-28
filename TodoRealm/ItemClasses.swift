//
//  ItemClasses.swift
//  TodoRealm
//
//  Created by クワシマ・ユウキ on 2021/05/29.
//  Copyright © 2021 クワシマ・ユウキ. All rights reserved.
//

import Foundation
import RealmSwift

class Parent: Object {
    @objc dynamic var title: String?
    
    let children = List<Child>()
}

class Child: Object {
    @objc dynamic var title: String?
}
