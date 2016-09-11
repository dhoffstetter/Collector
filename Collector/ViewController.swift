//
//  ViewController.swift
//  Collector
//
//  Created by Diane Hoffstetter on 9/6/16.
//  Copyright © 2016 Dumb Blonde Software. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
  @IBOutlet weak var tableView: UITableView!
  
  var collections : [Collection] = []
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    tableView.dataSource = self
    tableView.delegate = self
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  override func viewWillAppear(_ animated: Bool) {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    do {
      collections = try context.fetch(Collection.fetchRequest())
      print(collections)

    } catch {
      
    }
    
    tableView.reloadData()

  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return collections.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    let cell = UITableViewCell()
    
    let collection = collections[indexPath.row]
    
    cell.textLabel?.text = collection.title
    cell.imageView?.image = UIImage(data: collection.image as! Data)
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let collection = collections[indexPath.row]
    performSegue(withIdentifier: "collectionSegue", sender: collection)

  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
    let nextVC = segue.destination as! CollectionViewController
    nextVC.collection = sender as? Collection
    
  }

}

