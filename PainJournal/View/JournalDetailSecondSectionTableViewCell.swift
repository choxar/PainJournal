//
//  JournalDetailSecondSectionTableViewCell.swift
//  PainJournal
//
//  Created by elina.zambere on 23/04/2021.
//

import UIKit

class JournalDetailSecondSectionTableViewCell: UITableViewCell {
    
    @IBOutlet var painTitle: UILabel! {
        
        didSet {
            
            painTitle.numberOfLines = 0
            
        }
        
    }
    
    @IBOutlet var painPowerLabel: UILabel! {
        
        didSet {
            
            painPowerLabel.numberOfLines = 0
            
        }
        
    }
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
