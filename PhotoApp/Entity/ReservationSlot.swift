//
//  ReservationSlot.swift
//  PhotoApp
//
//  Created by arai kousuke on 2023/08/23.
//

import Foundation

class ReservationSlot {
    var time: String
    var isOpen: Bool
    
    init(time: String, isOpen: Bool) {
        self.time = time
        self.isOpen = isOpen
    }
}
