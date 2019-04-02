//
//  Registration Model.swift
//  HotelManzana
//
//  Created by Souley on 03/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation

struct Registration {
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Double
    var numberOfChildren: Double
    
    var roomType: RoomType
    var wifi: Bool
}
