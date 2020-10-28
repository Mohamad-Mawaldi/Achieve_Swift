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
    var taskName: String
}

class TaskViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var taskTV: UITableView!
    


    var tasks: [Task] = []
    var userID: String {
        return Auth.auth().currentUser?.uid ?? ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        taskTV?.delegate = self
        taskTV?.dataSource = self
        taskTV?.rowHeight = 80

       loadTasks()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "taskCell", for: indexPath) as! TaskCell
         cell.taskHeader.text = tasks[indexPath.row].taskName
          if tasks[indexPath.row].isDone {
             cell.checkmarkImage.image = UIImage(named:"checkmark")

         }else {

            cell.checkmarkImage.image = UIImage(named:"circleempty")
         }

        return cell
    }
    

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let ref = Database.database().reference(withPath: "users").child(self.userID).child("tasks").child(tasks[indexPath.row].taskName)

        if tasks[indexPath.row].isDone{
            tasks[indexPath.row].isDone = false
            ref.updateChildValues(["isChecked":false])
            
        } else {
            tasks[indexPath.row].isDone = true
            ref.updateChildValues(["isChecked":true])
        }
        
        self.taskTV?.reloadData()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let ref = Database.database().reference(withPath: "users").child(self.userID).child("tasks").child(tasks[indexPath.row].taskName)
        
        if editingStyle == .delete{
            ref.removeValue()
            tasks.remove(at: indexPath.row)
            taskTV.reloadData()
        }
    }

   func loadTasks() {
        let ref = Database.database().reference(withPath: "users").child(self.userID).child("tasks")
        ref.observeSingleEvent(of: .value) { (snapshot) in
            for child in snapshot.children.allObjects as! [DataSnapshot] {

                let taskHeader = child.key
                let taskRef = ref.child(taskHeader)

                taskRef.observeSingleEvent(of: .value) { (taskSnapshot) in
                    let value = taskSnapshot.value as? NSDictionary
                    let isChecked = value!["isChecked"] as? Bool

                    self.tasks.append(Task(isDone: isChecked ?? false, taskName: taskHeader))
                    self.taskTV?.reloadData()
                    
                    
                }
                
            }
        }
    }
    
    
    @IBAction func logOutAction(_ sender: Any) {
        
        try! Auth.auth().signOut()
        
        let storyboard = UIStoryboard(name: "Start", bundle: nil)
        let vc = storyboard.instantiateInitialViewController()
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
        
    }
    
    
    @IBAction func addTask(_ sender: Any) {
        
        let taskAlert = UIAlertController(title: "New Task", message: "Add A Task", preferredStyle: .alert)
        
        taskAlert.addTextField()
        
        let addTaskAction = UIAlertAction(title: "Add", style: .default) { (action) in
            let taskText = taskAlert.textFields![0].text
            self.tasks.append(Task(isDone: false, taskName: taskText!))
            
            
            let ref = Database.database().reference(withPath: "users").child(self.userID).child("tasks")
            ref.child(taskText!).setValue(["isChecked": false])
            
            self.taskTV.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        
        taskAlert.addAction(addTaskAction)
        taskAlert.addAction(cancelAction)
        
        present(taskAlert, animated: true, completion: nil)
        
        
        
    }
}
