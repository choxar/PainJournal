//
//  Journal.swift
//  PainJournal
//
//  Created by elina.zambere on 16/04/2021.
//

import Foundation

class Journal {
    
    var painType: String = ""
    var painDate: String = ""
    var painTime: String = ""
    var painNotes: String = ""
    var painImage: String = ""
    var painPower: String = ""
    
    init(painType: String, painDate: String, painTime: String, painNotes: String, painImage: String, painPower: String) {
        
        self.painType = painType
        self.painDate = painDate
        self.painTime = painTime
        self.painNotes = painNotes
        self.painImage = painImage
        self.painPower = painPower
    }
    
    convenience init() {
        self.init(painType: "", painDate: "", painTime: "", painNotes: "", painImage: "", painPower: "")
    }
    
    
    
}
