//
//  CollectionViewController.swift
//  Collector
//
//  Created by Diane Hoffstetter on 9/6/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit

class CollectionViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var collectionImageView: UIImageView!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var addUpdateButton: UIButton!
  @IBOutlet weak var deleteButton: UIButton!
  
  var imagePicker = UIImagePickerController()
  var collection : Collection? = nil
  
    override func viewDidLoad() {
        super.viewDidLoad()

        imagePicker.delegate = self
      
      if collection != nil {
        
        collectionImageView.image = UIImage(data: collection!.image as! Data)
        titleTextField.text = collection?.title
        
        addUpdateButton.setTitle("Update", for: .normal)
        
      } else {
        
        deleteButton.isHidden = true
      }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

  @IBAction func photosTapped(_ sender: AnyObject) {
    
    imagePicker.sourceType = .photoLibrary
    
    present(imagePicker, animated: true, completion: nil)
    
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
    
    let image = info[UIImagePickerControllerOriginalImage] as! UIImage
    collectionImageView.image = image
    
    imagePicker.dismiss(animated: true, completion: nil)
  }

  @IBAction func cameraTapped(_ sender: AnyObject) {
  }
  
  @IBAction func addTapped(_ sender: AnyObject) {
    
    if collection != nil {
      
      collection!.title = titleTextField.text
      collection!.image = UIImagePNGRepresentation(collectionImageView.image!)
      
    } else {
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
      
      let collection = Collection(context: context)
      collection.title = titleTextField.text
      collection.image = UIImagePNGRepresentation(collectionImageView.image!)

    }
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    navigationController!.popViewController(animated: true)
    
  }
  
  @IBAction func deleteTapped(_ sender: AnyObject) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    context.delete(collection!)
    
    (UIApplication.shared.delegate as! AppDelegate).saveContext()
    
    navigationController!.popViewController(animated: true)
    
  }
}






















