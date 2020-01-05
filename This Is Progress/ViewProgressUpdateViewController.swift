//
//  ViewProgressUpdateViewController.swift
//  This Is Progress
//
//  Created by Kyle Braden on 1/3/20.
//  Copyright © 2020 Kyle Braden. All rights reserved.
//

import UIKit

class ViewProgressUpdateViewController: UIViewController {
    
    var progressUpdate : ProgressUpdate?
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = progressUpdate?.title
        if let imageData = progressUpdate?.image {
            photoImageView.image = UIImage(data: imageData)
        }
    }
    

}
