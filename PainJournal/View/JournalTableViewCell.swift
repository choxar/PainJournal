//
//  JournalTableViewCell.swift
//  PainJournal
//
//  Created by elina.zambere on 15/04/2021.
//

import UIKit

class JournalTableViewCell: UITableViewCell {
    
    @IBOutlet var painTypeLabel: UILabel!
    @IBOutlet var painDateLabel: UILabel!
    @IBOutlet var painTimeLabel: UILabel!
    @IBOutlet var painPowerLabel: UILabel!
    @IBOutlet var thumbnailImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
