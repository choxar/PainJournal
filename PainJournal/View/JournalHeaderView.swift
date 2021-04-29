//
//  JournalHeader.swift
//  PainJournal
//
//  Created by elina.zambere on 16/04/2021.
//

import UIKit

class JournalHeaderView: UIView {
    
    @IBOutlet var painTypeImageView: UIImageView! 
    @IBOutlet var painDateLabel: UILabel! {
        
        didSet {
            
            painDateLabel?.numberOfLines = 0

            
        }
        
    }
    
    @IBOutlet var painTimeLabel: UILabel! {
        
        didSet {
            
            painTimeLabel.numberOfLines = 0

            
        }
        
    }
    @IBOutlet var painTitleFirst: UILabel! {
        
        didSet {
            
            painTitleFirst.numberOfLines = 0
        }
        
    }
 

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
