//
//  ViewController.swift
//  AppTasksDay
//
//  Created by MacAMP on 8/05/18.
//  Copyright © 2018 MacAMP. All rights reserved.
//

import UIKit

class TaskDayViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tblTasksDay: UITableView!
    var tareas = [Tarea]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tareas = Array(DBManager.sharedInstance.getTareaFromDB())
        self.tblTasksDay.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func backButtonPressed(_ sender: Any) {
    }
    
    @IBAction func addTaskPressed(_ sender: Any) {
        let alert = UIAlertController(title: "Nueva Tarea",
                                      message: "Añade una nueva tarea",
                                      preferredStyle: .alert)
        
        //Creamos el UIAlertAction que nos permitirá guardar la tarea
        let saveAction = UIAlertAction(title: "Guardar",
                                       style: .default,
                                       handler: { (action:UIAlertAction) -> Void in
                                        //Guardamos el texto del textField en el array tasks y recargamos la table view
                                        let textField = alert.textFields!.first
                                        let tareanueva = Tarea(Int(arc4random()),textField!.text!,"Sin hacer")
                                        self.tareas.append(tareanueva)
                                        DBManager.sharedInstance.addInternalNew(object: tareanueva)
                                        //self.tasks.append(textField!.text!)
                                        self.tblTasksDay.reloadData()
        })
        //Creamos el UIAlertAction que nos permitirá cancelar
        let cancelAction = UIAlertAction(title: "Cancelar",
                                         style: .default) { (action: UIAlertAction) -> Void in}
        
        alert.addTextField{
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert,
                animated: true,
                completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tareas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tblTasksDay.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath) as! TaskTableViewCell
        let tarea = tareas[indexPath.row]
        cell.titleTask.text = tarea.descripcion
        cell.estadoTask.text = tarea.estado
        if(tarea.estado == "En Progreso"){
            cell.estadoTask.textColor = .orange
            cell.viewbgTask.backgroundColor = .orange
        }else if(tarea.estado == "Sin hacer"){
            cell.estadoTask.textColor = .red
            cell.viewbgTask.backgroundColor = .red
        }else{
            cell.estadoTask.textColor = .green
            cell.viewbgTask.backgroundColor = .green
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        /*
         if editingStyle == .delete {
         
         // remove the item from the data model
         //let tarea = tareas[indexPath.row]
         tareas.remove(at: indexPath.row)
         //tasks.remove(at: indexPath.row)
         
         // delete the table view row
         tableView.deleteRows(at: [indexPath], with: .fade)
         
         } else if editingStyle == .insert {
         // Not used in our example, but if you were adding a new row, this is where you would do it.
         }*/
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Eliminar") { (action, indexpath) in
            print(self.tareas[indexPath.row])
            DBManager.sharedInstance.deleteInternalNewFromDb(object: self.tareas[indexPath.row])
            self.tareas.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        deleteAction.backgroundColor = .red
        let estadoAction = UITableViewRowAction(style: .normal, title: "En Progreso") { (action, indexpath) in
            
            //self.tareas[indexPath.row].estado = "En Progreso"
            DBManager.sharedInstance.updateInternalNewStateFromDb(object: self.tareas[indexPath.row], estado: "En Progreso")
            
            self.tblTasksDay.reloadData()
            
        }
        estadoAction.backgroundColor = .orange
        let finishAction = UITableViewRowAction(style: .normal, title: "Realizado") { (action, indexpath) in
            //self.tareas[indexPath.row].estado = "Realizado"
            DBManager.sharedInstance.updateInternalNewStateFromDb(object: self.tareas[indexPath.row], estado: "Realizado")
            self.tblTasksDay.reloadData()
            
        }
        finishAction.backgroundColor = .green
        return [deleteAction, estadoAction,finishAction ]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}

