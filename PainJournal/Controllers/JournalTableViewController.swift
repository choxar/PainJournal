//
//  JournalTableViewController.swift
//  PainJournal
//
//  Created by elina.zambere on 15/04/2021.
//

import UIKit
import CoreData



class JournalTableViewController: UITableViewController, NSFetchedResultsControllerDelegate, UISearchResultsUpdating {
    
    
    class CoreData {
        
        // MARK: - Core Data stack
        
        lazy var persistentContainer: NSPersistentContainer = {
            /*
             The persistent container for the application. This implementation
             creates and returns a container, having loaded the store for the
             application to it. This property is optional since there are legitimate
             error conditions that could cause the creation of the store to fail.
             */
            let container = NSPersistentContainer(name: "PainJournal")
            container.loadPersistentStores(completionHandler: { (storeDescription, error) in
                if let error = error as NSError? {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            })
            return container
        }()
        
        // MARK: - Core Data Saving support
        
        func saveContext () {
            let context = persistentContainer.viewContext
            if context.hasChanges {
                do {
                    try context.save()
                } catch {
                    // Replace this implementation with code to handle the error appropriately.
                    // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    let nserror = error as NSError
                    fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
                }
            }
        }

        
    }
    
    var fetchResultController: NSFetchedResultsController<JournalMO>!
    
    
    @IBOutlet var emptyView: UIView!
        
    
    var pains: [JournalMO] = []
    
    var searchController = UISearchController()
    
    var searchResults: [JournalMO] = []
    
    var coreData = CoreData()
        
    // MARK:- View controller life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "iPhone 8 Plus - 1"))

        
   // Search bar methods
        
        searchController = UISearchController(searchResultsController: nil)
      self.navigationItem.searchController = searchController
      //  tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        
  //Customization of SearchBar
        
        searchController.searchBar.placeholder = "Search for records..."
        searchController.searchBar.barTintColor = .white
        searchController.searchBar.backgroundImage = UIImage()
        searchController.searchBar.tintColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 1)
        
        
  // Customize the navigation bar
        
        self.navigationController!.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Palatino", size: 22)!]

        
        navigationController?.hidesBarsOnSwipe = true
        
        //Prepare the empty view
        
        tableView.backgroundView = emptyView
        tableView.backgroundView?.isHidden = true
        
        //Fetch Data from Data store
        
        let fetchRequest: NSFetchRequest<JournalMO> = JournalMO.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "painDate", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
            let context = coreData.persistentContainer.viewContext
            fetchResultController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
            fetchResultController.delegate = self

            do {

                try fetchResultController.performFetch()
                if let fetchedObjects = fetchResultController.fetchedObjects {

                    pains = fetchedObjects

                }
            } catch {
                print(error)

            }
        
        
    }
    

  
    
    override func viewWillAppear(_ animated: Bool) {
        
//        self.clearsSelectionOnViewWillAppear = ((self.splitViewController?.isCollapsed) != nil)
//
//        super.viewWillAppear(animated)
//
//        navigationController?.hidesBarsOnSwipe = true
//
//        let backgroundImage = UIImage(named: "iPhone 8 Plus - 1")
//        let imageView = UIImageView(image: backgroundImage)
//        self.tableView.backgroundView = imageView
//
//        tableView.tableFooterView = UIView(frame: CGRect.zero)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        if pains.count > 0 {
            
            tableView.backgroundView?.isHidden = true
            tableView.separatorStyle = .singleLine
            
        } else {
            
            tableView.backgroundView?.isHidden = false
            tableView.separatorStyle = .none
            
        }
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if searchController.isActive {
            
            return searchResults.count
            
        } else {
            
            return pains.count

        }
        
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.backgroundColor = .clear

        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! JournalTableViewCell
        
        
        let record = (searchController.isActive) ? searchResults[indexPath.row] : pains[indexPath.row]
        
        //MARK: Configure the cell...
        
        cell.painTypeLabel.text = record.painType
        cell.painDateLabel.text = record.painDate
        cell.painTimeLabel.text = record.painTime
        cell.painPowerLabel.text = record.painPower
        
        if let painThumbImage = record.painImage {
            
            cell.thumbnailImageView.image = UIImage(data: painThumbImage as Data)
            
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    

    
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if searchController.isActive {
            
            return false
            
        }
        
        else {
            
            return true
            
        }
    }
    
    

    
    //MARK:- Remove
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

            let deleteAction = UIContextualAction(style: .destructive, title: "") { (action, sourceView, completionHandler) in

                
                // Delete the row from the data source
                
                    let context = self.coreData.persistentContainer.viewContext
                    let recordToDelete = self.fetchResultController.object(at: indexPath)

                    context.delete(recordToDelete)

                self.coreData.saveContext()
            
                self.tableView.reloadData()
                
            completionHandler(true)

                

            }

            

            deleteAction.backgroundColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)

            deleteAction.image = UIImage(named: "delete")

            

            let swipeConfiguration = UISwipeActionsConfiguration(actions: [deleteAction])

            

            return swipeConfiguration

        }
         

              
            

    
    
    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if segue.identifier == "showPainDetail" {
            
            let indexPath = self.tableView.indexPathForSelectedRow
                
                let destinationController = segue.destination as? JournalDetailViewController
            destinationController?.journal = (searchController.isActive) ? searchResults[indexPath!.row] : pains[indexPath!.row]
            
            self.tableView.deselectRow(at: indexPath!, animated: true)
        }
        
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Fetch Request Methods
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }

    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            if let newIndexPath = newIndexPath {
                tableView.insertRows(at: [newIndexPath], with: .fade)
            }
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        case .update:
            if let indexPath = indexPath {
                tableView.reloadRows(at: [indexPath], with: .fade)
            }
        default:
            tableView.reloadData()
        }

        if let fetchedObjects = controller.fetchedObjects {
            pains = fetchedObjects as! [JournalMO]
        }
    }

    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    //MARK: - SearchBar methods
    
    func filterContent(for SearchText: String) {
        searchResults = pains.filter({ (pain) -> Bool in
            if let type = pain.painType {
                let isMatch = type.localizedCaseInsensitiveContains(SearchText)
                return isMatch
            }
            
            return false
        })
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            filterContent(for: searchText)
            tableView.reloadData()
        }
    }
    
}

