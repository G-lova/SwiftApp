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
                print(friends)
                completion(friends.response.items)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getPhotosData() {
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
    
}
