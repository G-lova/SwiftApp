//
//  FileCache.swift
//  VkSwiftApp
//
//  Created by User on 05.02.2024.
//

import Foundation
import CoreData

class FileCache {
    
    lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "FriendsDataModel")
        persistentContainer.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error {
                print(error)
            }
        })
        return persistentContainer
    }()
    
    func save() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    func delete(object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
        save()
    }
    
    //MARK: - Add Methods
    
    func addFriends(friends: [FriendItems]) {
//        let fetchRequest: NSFetchRequest<FriendsModel> = FriendsModel.fetchRequest()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "FriendsModel")
        let existingFriends = try? persistentContainer.viewContext.fetch(fetchRequest)
        if let existingFriends = existingFriends {
            for friend in existingFriends {
                persistentContainer.viewContext.delete(friend as! NSManagedObject)
            }
        }
        
        for friend in friends {
            let friendModel = FriendsModel(context: persistentContainer.viewContext)
            friendModel.friendID = friend.id
            friendModel.friendFirstName = friend.first_name
            friendModel.friendLastName = friend.last_name
            friendModel.isOnline = friend.online
            friendModel.friendPhoto = friend.photo_50
        }
        save()
    }
    
    func addGroups(groups: [GroupsItems]) {
//        let fetchRequest: NSFetchRequest<FriendsModel> = FriendsModel.fetchRequest()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "GroupModel")
        let existingGroups = try? persistentContainer.viewContext.fetch(fetchRequest)
        if let existingGroups = existingGroups {
            for group in existingGroups {
                persistentContainer.viewContext.delete(group as! NSManagedObject)
            }
        }
        
        for group in groups {
            let groupModel = GroupModel(context: persistentContainer.viewContext)
            groupModel.groupName = group.name
            groupModel.groupDescription = group.description
            groupModel.groupPhoto = group.photo_50
        }
        save()
    }
    
    //MARK: - Fetch Methods
    
    func fetchFriends() -> [FriendItems] {
        let fetchRequest: NSFetchRequest<FriendsModel> = FriendsModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isOnline", ascending: false)]
        guard let friends = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newFriends: [FriendItems] = []
        for friend in friends {
            newFriends.append(FriendItems(id: friend.friendID, online: friend.isOnline, first_name: friend.friendFirstName, last_name: friend.friendLastName, photo_50: friend.friendPhoto))
        }
        return newFriends
    }
    
    func fetchGroups() -> [GroupsItems] {
        let fetchRequest: NSFetchRequest<GroupModel> = GroupModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "groupName", ascending: true)]
        guard let groups = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newGroups: [GroupsItems] = []
        for group in groups {
            guard let description = group.groupDescription else {
                continue
            }
            newGroups.append(GroupsItems(name: group.groupName, description: description, photo_50: group.groupPhoto))
        }
        return newGroups
    }
    
    //MARK: - Load Methods
    
    func loadFriendsFromCoreData(completion: @escaping( NSFetchedResultsController<FriendsModel>) -> Void) {
        
        let fetchRequest: NSFetchRequest<FriendsModel> = FriendsModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "isOnline", ascending: false)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
            completion(fetchedResultsController)
        } catch {
            print(error)
        }
    }
    
    func loadGroupsFromCoreData(completion: @escaping( NSFetchedResultsController<GroupModel>) -> Void) {
        
        let fetchRequest: NSFetchRequest<GroupModel> = GroupModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "groupName", ascending: true)]
        
        let fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: persistentContainer.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        do {
            try fetchedResultsController.performFetch()
            completion(fetchedResultsController)
        } catch {
            print(error)
        }
    }
}
