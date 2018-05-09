//
//  Tarea.swift
//  AppTasksDay
//
//  Created by MacAMP on 8/05/18.
//  Copyright © 2018 MacAMP. All rights reserved.
//

import Foundation
import RealmSwift

class Tarea : Object
{
    //var idusuario: Int
    @objc dynamic var idtarea: Int = 0
    @objc dynamic var descripcion: String?
    @objc dynamic var estado: String?
    
    override static func primaryKey() -> String? {
        return "idtarea"
    }
    
    convenience required init(_ idtarea: Int,_ descripcion: String,_ estado: String) {
        self.init()
        self.idtarea=idtarea
        self.descripcion=descripcion
        self.estado=estado
        
    }
    
    
}
