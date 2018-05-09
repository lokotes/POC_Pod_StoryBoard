//
//  ViewController.swift
//  LifeTasks
//
//  Created by MacAMP on 8/05/18.
//  Copyright © 2018 MacAMP. All rights reserved.
//

import UIKit
import AppTasksDay

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet weak var viewTasksDay: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.openModule))
        tap.delegate = self
        self.viewTasksDay.addGestureRecognizer(tap)
    }

    @objc func openModule(){
        let matches = Bundle.allFrameworks.filter { (aBundle) -> Bool in
            guard let identifier = aBundle.bundleIdentifier else {        return false }
            
            return identifier.contains("AppTasksDay") && aBundle.isLoaded
        }
        if !matches.isEmpty {
            let storyboard = UIStoryboard(name: "TaskDay", bundle: matches.last!)
            let viewController = storyboard.instantiateInitialViewController()
            self.navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

