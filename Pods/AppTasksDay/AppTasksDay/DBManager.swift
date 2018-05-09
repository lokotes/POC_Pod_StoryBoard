//
//  DBManager.swift
//  AppTasksDay
//
//  Created by MacAMP on 9/05/18.
//  Copyright © 2018 MacAMP. All rights reserved.
//

import UIKit
import RealmSwift

class DBManager {
    
    private var database:Realm
    static let sharedInstance = DBManager()
    
    private init() {
        
        database = try! Realm()
        
    }
    
    func getTareaFromDB() -> Results<Tarea> {
        
        let results: Results<Tarea> = database.objects(Tarea.self)
        return results
    }
    
    func addInternalNew(object: Tarea) {
        
        try! database.write {
            database.add(object, update: true)
            print("Added new object")
        }
    }
    
    func deleteInternalNewFromDb(object: Tarea) {
        
        try! database.write {
            
            database.delete(object)
        }
    }
    
    /*func deleteInternalNewsFromDb() {
     
     try! database.write {
     
     database.delete(getInternalNewsFromDB())
     }
     }*/
    
    
    func updateInternalNewStateFromDb(object: Tarea, estado: String) {
        
        try! database.write {
            object.setValue(estado, forKey: "estado")
            //InternalNew.setValue("1", forKeyPath: "estado")
        }
    }
    
    
}
