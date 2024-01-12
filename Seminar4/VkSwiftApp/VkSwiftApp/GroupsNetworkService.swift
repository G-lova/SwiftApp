//
//  GroupsNetworkService.swift
//  VkSwiftApp
//
//  Created by User on 04.01.2024.
//

import Foundation

final class GroupsNetworkService {
    
    var token: String = ""
    var userID: String = ""
        
    func getGroupsData(photoCompletion: @escaping ([GroupsItems]) -> Void) {
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
                photoCompletion(groups.response.items)
                
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getGroupImage(urlString: String, completion: @escaping (Data?, Error?) -> Void) {
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
