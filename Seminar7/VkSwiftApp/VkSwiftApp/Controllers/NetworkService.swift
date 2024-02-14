//
//  NetworkService.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import UIKit
import CoreData

protocol NetworkServiceProtocol {
    func getFriendsData(completion: @escaping ([FriendItems]) -> Void, errorHandler: @escaping() -> Void)
    
    func getGroupsData(groupCompletion: @escaping ([GroupsItems]) -> Void)
    
    func getPhotosData(photoCompletion: @escaping ([UIImage]) -> Void)
    
    func getProfileData(userID: String, completion: @escaping ([ProfileItems]) -> Void)
}

final class NetworkService: NetworkServiceProtocol {
    
    private let token = AccessManager.shared.token
    private let userID = AccessManager.shared.userID
    
    var fileCache: FileCache = FileCache()
        
    func getFriendsData(completion: @escaping ([FriendItems]) -> Void, errorHandler: @escaping() -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?access_token=\(token)&user_id=\(userID)&fields=first_name,last_name,online,photo_50&v=5.199") else {
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let friends = try JSONDecoder().decode(Friend.self, from: data)
//                print(friends)
                self.fileCache.addFriends(friends: friends.response.items)
                
                let dateManager = DateManager.shared
                dateManager.friendsUpdatingDate = Date()
                
                completion(friends.response.items)
            } catch {
                errorHandler()
                
                print(error)
            }
        }.resume()
    }
    
func getGroupsData(groupCompletion: @escaping ([GroupsItems]) -> Void) {
    guard let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(token)&user_id=\(userID)&extended=1&fields=name,description,photo_50&v=5.199") else {
        return
    }
    URLSession.shared.dataTask(with: url) {(data, response, error) in
        guard let data = data else {
            return
        }
//            guard let response = response as? HTTPURLResponse else {
//                return
//            }
        do {
            let groups = try JSONDecoder().decode(Group.self, from: data)
//            print(groups)
            self.fileCache.addGroups(groups: groups.response.items)
            groupCompletion(groups.response.items)
            
        } catch {
            print(error)
        }
    }.resume()
}
    
    func getPhotosData(photoCompletion: @escaping ([UIImage]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/photos.get?access_token=\(token)&owner_id=\(userID)&album_id=wall&v=5.199") else {
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            print(data)
            guard let response = response as? HTTPURLResponse else {
                return
            }
            print(response)
            do {
                let photos = try JSONDecoder().decode(Photo.self, from: data)
                print(photos)
                
                var photoImages: [UIImage] = []
                for item in photos.response.items {
                    let url = URL(string: item.url)
                    if let data = try? Data(contentsOf: url!) {
                        if let image = UIImage(data: data) {
                            photoImages.append(image)
                        }
                    }
                }
                photoCompletion(photoImages)
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getImage(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }.resume()
    }
    
    func getProfileData(userID: String, completion: @escaping ([ProfileItems]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/users.get?access_token=\(token)&user_ids=\(userID)&fields=first_name,last_name,photo_200&v=5.199") else {
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            do {
                let profile = try JSONDecoder().decode(Profile.self, from: data)
                print(profile)
                completion(profile.response)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
