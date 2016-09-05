//
//  MasterViewController.swift
//  AAA
//
//  Created by Anton Pavlov on 05.09.16.
//  Copyright © 2016 Anton Pavlov. All rights reserved.
//

import UIKit
import CoreData

class MasterViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    let managedObjectContext =  DataManager.sharedInstance.managedObjectContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.title = "Сохраненные колоды"
        self.editButtonItem().title = "Правка";
        
    }
    
    override func setEditing(editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        if editing{
            self.editButtonItem().title = "Готово"
        }else{
            self.editButtonItem().title = "Правка"
        }
    }
    
    override func tableView(tableView: UITableView, titleForDeleteConfirmationButtonForRowAtIndexPath indexPath: NSIndexPath) -> String? {
        return "Удалить"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //     MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showCountFromMaster" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Map
                let controller = segue.destinationViewController as! CountTableViewController
                
                controller.detailItemFromMaster = object
            }
        }
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.fetchedResultsController.sections?.count ?? 0
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = self.fetchedResultsController.objectAtIndexPath(indexPath) as! Map
        self.configureCell(cell, withObject: object)
        return cell
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let context = self.fetchedResultsController.managedObjectContext
            context.deleteObject(self.fetchedResultsController.objectAtIndexPath(indexPath) as! Map)
            
            do {
                try context.save()
            } catch {
                abort()
            }
        }
    }
    
    func configureCell(cell: UITableViewCell, withObject object: Map) {
        cell.textLabel!.text = object.title
        cell.detailTextLabel?.text = "Жители:\(object.cardDeck[0]), Комиссар:\(object.cardDeck[1]) , Мафия:\(object.cardDeck[2] + object.cardDeck[3]), Доктор:\(object.cardDeck[4]), Любовница:\(object.cardDeck[5]), Маньяк:\(object.cardDeck[6])"
    }
    
    
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest()
        let entity = NSEntityDescription.entityForName("Map", inManagedObjectContext: self.managedObjectContext)
        fetchRequest.entity = entity
        
        fetchRequest.fetchBatchSize = 20
        
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            abort()
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController? = nil
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        self.tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeSection sectionInfo: NSFetchedResultsSectionInfo, atIndex sectionIndex: Int, forChangeType type: NSFetchedResultsChangeType) {
        switch type {
        case .Insert:
            self.tableView.insertSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        case .Delete:
            self.tableView.deleteSections(NSIndexSet(index: sectionIndex), withRowAnimation: .Fade)
        default:
            return
        }
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Fade)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Fade)
        case .Update:
            self.configureCell(tableView.cellForRowAtIndexPath(indexPath!)!, withObject: anObject as! Map)
        case .Move:
            tableView.moveRowAtIndexPath(indexPath!, toIndexPath: newIndexPath!)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.endUpdates()
    }
    
    
}

