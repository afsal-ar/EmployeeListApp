//
//  Geo+CoreDataProperties.swift
//  
//
//  Created by InApp on 17/09/22.
//
//

import Foundation
import CoreData


extension Geo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Geo> {
        return NSFetchRequest<Geo>(entityName: "Geo")
    }

    @NSManaged public var lat: String?
    @NSManaged public var lng: String?
    @NSManaged public var address: Address?

}
