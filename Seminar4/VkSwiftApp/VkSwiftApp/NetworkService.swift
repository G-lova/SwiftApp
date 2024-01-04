//
//  NetworkService.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation

final class NetworkService {
    
    var token: String = ""
    var userID: String = ""
        
    func getFriendsData() {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?access_token=\(token)&user_id=\(userID)&field=first_name,last_name,online&v=5.199") else {
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
                let friends = try JSONDecoder().decode(Friend.self, from: data)
                print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroupsData(completion: @escaping ([GroupsItems]) -> Void) {
        guard let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(token)&user_id=\(userID)&extended=1&fields=name&v=5.199") else {
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
                let groups = try JSONDecoder().decode(Group.self, from: data)
                print(groups)
                completion(groups.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotosData() {
        guard let url = URL(string: "https://api.vk.com/method/photos.getAll?access_token=\(token)&owner_id=\(userID)&v=5.199") else {
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
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
