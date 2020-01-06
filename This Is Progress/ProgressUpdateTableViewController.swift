//
//  ProgressUpdateTableViewController.swift
//  This Is Progress
//
//  Created by Kyle Braden on 1/1/20.
//  Copyright © 2020 Kyle Braden. All rights reserved.
//

import UIKit

class ProgressUpdateTableViewController: UITableViewController {

    var updates : [ProgressUpdate] = []
    
//    UINavigationBar.appearance().titleTextAttributes = NSAttributedString.Key.font: UIFont(name: "Georgia-Bold", size: 24)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AmericanTypewriter", size: 21)!]
    }

    override func viewWillAppear(_ animated: Bool) {
        getCoreDataInfo()
    }
    
    func getCoreDataInfo() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            if let coreDataProgressUpdates = try? context.fetch(ProgressUpdate.fetchRequest()) as? [ProgressUpdate] {
                updates = coreDataProgressUpdates
                tableView.reloadData()
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "progressCell", for: indexPath)

        let progressUpdate = updates[indexPath.row]
        if let imageData = progressUpdate.image {
            cell.imageView?.image = UIImage(data: imageData)
        }
        
        cell.textLabel?.text = progressUpdate.title

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let progressUpdate = updates[indexPath.row]
            if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
                context.delete(progressUpdate)
                getCoreDataInfo()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let progressUpdate = updates[indexPath.row]
        performSegue(withIdentifier: "showUpdate", sender: progressUpdate)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewProgressUpdateVC = segue.destination as? ViewProgressUpdateViewController {
            if let progressUpdate = sender as? ProgressUpdate {
              viewProgressUpdateVC.progressUpdate = progressUpdate
            }
        }
    }

}
