//
//  NetworkService.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation
//import CoreData

final class NetworkService {
    
    private let token = AccessManager.shared.token
    private let userID = AccessManager.shared.userID
    
    let fileCache: FileCache = FileCache()
        
    func getFriendsData(completion: @escaping ([FriendItems]) -> Void) {
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
                completion(friends.response.items)
                self.fileCache.addFriends(friends: friends.response.items)
            } catch {
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
            print(groups)
            groupCompletion(groups.response.items)
            
        } catch {
            print(error)
        }
    }.resume()
}
    
    func getPhotosData(photoCompletion: @escaping ([PhotoItems]) -> Void) {
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
                photoCompletion(photos.response.items)
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
