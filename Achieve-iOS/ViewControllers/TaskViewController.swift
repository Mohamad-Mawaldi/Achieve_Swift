//
//  TaskViewController.swift
//  Achieve-iOS
//
//  Created by Mohamad on 2020-10-20.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth


struct Task {
    var isDone: Bool
    var taskName:String
}

class TaskViewController: UITabBarController, UITableViewDelegate, UITableViewDataSource  {
    


    @IBOutlet weak var taskTV: UITableView!
    
    //var tasks : [Task] = ["task 1", "task 2", "task 3"]
    var tasks : [String] = ["task 1", "task 2", "task 3"]

    var userID : String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        taskTV?.delegate = self
        taskTV?.dataSource = self
       
        
    NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveData(_:)), name: Notification.Name("userID"), object: nil)
       //loadTasks()
        
        
    }
    
    
    @objc func onDidReceiveData(_ notification:Notification) {
        self.userID = notification.object as! String
        print("-----------------works here too!!!!!!!!!!!!!", self.userID)
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
        cell.taskHeader.text = tasks[indexPath.row]
        /* cell.header.text = tasks[indexPath.row].taskName
        if tasks[indexPath.row].isDone {
            cell.checkmarkImage.image = UIImage(named: "checkmark.png")
            
        }else {

            cell.checkmarkImage.image = UIImage(named: "checkmark.png")
        }*/
        
        return cell
    }
    
    
    
   /* func loadTasks(){
        let ref = Database.database().reference(withPath: "users").child(self.userID).child("tasks")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let taskHeader = child.key
                let todoRef = ref.child(taskHeader)
                
                todoRef.observeSingleEvent(of: .value) { (taskSnapshot) in
                    let value = taskSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool
                    
                    self.tasks.append(Task(isDone: isChecked!, taskName: taskHeader))
                    
                    
                }
            }
        }
        self.taskTV.reloadData()
        
    }
 */
    

}
