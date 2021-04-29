//
//  JournalDetailViewController.swift
//  PainJournal
//
//  Created by elina.zambere on 16/04/2021.
//

import UIKit

class JournalDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var headerView: JournalHeaderView!
    @IBOutlet var tableView: UITableView!
    
    @IBAction func editButton(_ sender: Any) {
        
    }
    
    var journal: JournalMO!
    var selectedRecord: JournalMO!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Customization of the nav bar
        
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.largeTitleDisplayMode = .never
        
        //MARK: - Passing Image to Navigation Controller
        
        if let painThumbImage = journal?.painImage {
            
            headerView.painTypeImageView.image = UIImage(data: painThumbImage as Data)
            
        }
        
        headerView?.painDateLabel.text = journal?.painDate
        headerView?.painTimeLabel.text = journal?.painTime
        headerView?.painTitleFirst.text = journal?.painType

        
        // Configure the table view
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none

        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.hidesBarsOnSwipe = false
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.hidesBarsOnSwipe = false
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
        case 0:
            
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JournalDetailSecondSectionTableViewCell.self), for: indexPath) as! JournalDetailSecondSectionTableViewCell
            
            cell.painTitle.text = journal?.painType
            cell.painPowerLabel.text = journal?.painPower
            
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: JournalDetailNotesTextCell.self), for: indexPath) as! JournalDetailNotesTextCell
            cell.notesLabel.text = journal?.painNotes
            
            return cell
            
            default:
            fatalError("Failed to instantiate the table view cell for detail view controller")
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
