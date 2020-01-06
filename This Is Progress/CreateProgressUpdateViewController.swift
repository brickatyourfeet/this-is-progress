//
//  CreateProgressUpdateViewController.swift
//  This Is Progress
//
//  Created by Kyle Braden on 1/1/20.
//  Copyright © 2020 Kyle Braden. All rights reserved.
//

import UIKit

class CreateProgressUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var photoImageView: UIImageView!
    //replace photo with similar font image that says "upload progress photo"
    @IBOutlet weak var titleTextField: UITextField!
    //add date field for date attribute in ProgressUpdate entity
    @IBOutlet weak var addButton: UIButton!
    var pickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "This is Progress"
        
        addButton.layer.cornerRadius = addButton.frame.size.height / 2
        
        pickerController.delegate = self
        

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            photoImageView.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func existingPhotoTapped(_ sender: Any) {
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func cameraTapped(_ sender: Any) {
        pickerController.sourceType = .camera
        present(pickerController, animated: true, completion: nil)
    }
    
    @IBAction func addTapped(_ sender: Any) {
        
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            let progressUpdateToBeSaved = ProgressUpdate(context: context)
            progressUpdateToBeSaved.title = titleTextField.text
            progressUpdateToBeSaved.image = photoImageView.image?.jpegData(compressionQuality: 1.0)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
        
        navigationController?.popViewController(animated: true)
    }
    

}
