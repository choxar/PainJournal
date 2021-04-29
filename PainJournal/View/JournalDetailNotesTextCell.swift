//
//  JournalDetailNotesTextCell.swift
//  PainJournal
//
//  Created by elina.zambere on 19/04/2021.
//

import UIKit

class JournalDetailNotesTextCell: UITableViewCell {
    
    @IBOutlet var notesLabel: UILabel! {
        
        didSet {
            
            notesLabel.numberOfLines = 0
            
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
