//
//  GroupModel+CoreDataProperties.swift
//  VkSwiftApp
//
//  Created by User on 12.02.2024.
//
//

import Foundation
import CoreData


extension GroupModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<GroupModel> {
        return NSFetchRequest<GroupModel>(entityName: "GroupModel")
    }

    @NSManaged public var groupDescription: String?
    @NSManaged public var groupName: String
    @NSManaged public var groupPhoto: String

}

extension GroupModel : Identifiable {

}
