//
//  ClientModel.swift
//  HotelManzana
//
//  Created by Servicio Esteban  on 29/09/18.
//  Copyright © 2018 Servicio Esteban . All rights reserved.
//

import Foundation



struct Registration: Codable {

    
    var firstName: String
    var lastName: String
    var emailAddress: String
    
    var checkInDate: Date
    var checkOutDate: Date
    var numberOfAdults: Int
    var numberOfChildren: Int
    
    var roomType: RoomType
    var wifi: Bool
    
    
    static let DocumentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("registrations").appendingPathExtension("plist")
    
    static func loadRegistrations() -> [Registration]?  {
        guard let codedRegistrations = try? Data(contentsOf: ArchiveURL)
            else {return nil}
        let propertyListDecoder = PropertyListDecoder()
        return try? propertyListDecoder.decode(Array<Registration>.self,
                                               from: codedRegistrations)
    }
    
    static func saveRegistrations(_ registrations: [Registration]) {
        let propertyListEncoder = PropertyListEncoder()
        let codedRegistrations = try? propertyListEncoder.encode(registrations)
        try? codedRegistrations?.write(to: ArchiveURL,
                               options: .noFileProtection)
    }
}

struct RoomType: Equatable, Codable {
    var id: Int
    var name: String
    var shortName: String
    var price: Int
    
    static var all: [RoomType] {
        return [RoomType(id: 0, name: "Two Queens", shortName: "2Q",
                         price: 179),
                RoomType(id: 1, name: "One King", shortName: "K",
                         price: 209),
                RoomType(id: 2, name: "Penthouse Suite", shortName:
                    "PHS", price: 309)]
    }
    
}

//Equatable Protocol Implementation for RoomType
func ==(lhs: RoomType, rhs: RoomType) -> Bool {
    return lhs.id == rhs.id
}


