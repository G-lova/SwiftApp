//
//  NetworkService.swift
//  Seminar3
//
//  Created by User on 26.12.2023.
//

import Foundation

final class NetworkService {
    
    func getFriendsData(token: String?, userID: String?) {
        guard let url = URL(string: "https://api.vk.com/method/friends.get?access_token=\(token)&user_id=\(userID)&order=name&v=5.199") else {
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
                let friends = try JSONDecoder().decode([Friend].self, from: data)
                print(friends)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroupsData(token: String?, userID: String?) {
        guard let url = URL(string: "https://api.vk.com/method/groups.get?access_token=\(token)&user_id=\(userID)&v=5.199") else {
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
                let groups = try JSONDecoder().decode([Group].self, from: data)
                print(groups)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotosData(token: String?, userID: String?) {
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
                let photos = try JSONDecoder().decode([Photo].self, from: data)
                print(photos)
            } catch {
                print(error)
            }
        }.resume()
    }
    
}
