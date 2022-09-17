//
//  Employee+CoreDataProperties.swift
//  
//
//  Created by InApp on 17/09/22.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var email: String?
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var profile_image: String?
    @NSManaged public var username: String?
    @NSManaged public var website: String?
    @NSManaged public var address: Address?
    @NSManaged public var company: Company?

}
