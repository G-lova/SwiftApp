//
//  FriendsModel+CoreDataProperties.swift
//  VkSwiftApp
//
//  Created by User on 05.02.2024.
//
//

import Foundation
import CoreData


extension FriendsModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FriendsModel> {
        return NSFetchRequest<FriendsModel>(entityName: "FriendsModel")
    }

    @NSManaged public var friendID: Int64
    @NSManaged public var friendFirstName: String
    @NSManaged public var friendLastName: String
    @NSManaged public var isOnline: Int16
    @NSManaged public var friendPhoto: String

}

extension FriendsModel : Identifiable {

}
