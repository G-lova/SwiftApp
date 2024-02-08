//
//  FileCache.swift
//  VkSwiftApp
//
//  Created by User on 05.02.2024.
//

import Foundation
import CoreData

class FileCache {
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let persistentContainer = NSPersistentContainer(name: "FriendsModel")
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
    
    func addFriends(friends: [FriendItems]) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult> (entityName: "FriendsModel")
        for friend in friends {
            fetchRequest.predicate = NSPredicate(format: "friendID = %@", argumentArray: [friend.id])
            let result = try? persistentContainer.viewContext.fetch(fetchRequest)
            guard result?.first == nil else {
                continue
            }
            
            let friendModel = FriendsModel(context: persistentContainer.viewContext)
            friendModel.friendID = friend.id
            friendModel.friendFirstName = friend.first_name
            friendModel.friendLastName = friend.last_name
            friendModel.isOnline = friend.online
            friendModel.friendPhoto = friend.photo_50
        }
        save()
    }
    
    func fetchFriends() -> [FriendItems] {
        let fetchRequest: NSFetchRequest<FriendsModel> = FriendsModel.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "friendLastName", ascending: true)]
        guard let friends = try? persistentContainer.viewContext.fetch(fetchRequest) else {
            return []
        }
        var newFriends: [FriendItems] = []
        for friend in friends {
            newFriends.append(FriendItems(id: friend.friendID, online: friend.isOnline, first_name: friend.friendFirstName, last_name: friend.friendLastName, photo_50: friend.friendPhoto))
        }
        return newFriends
    }
}
