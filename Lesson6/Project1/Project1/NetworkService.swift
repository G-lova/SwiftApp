//
//  NetworkService.swift
//  Project1
//
//  Created by User on 01.02.2024.
//

import Foundation

final class NetworkService {
    
    func getData(completion: @escaping ([Town]) -> Void) {
        guard let url = URL(string: "https://kudago.com/public-api/v1.4/locations/?lang=ru&fields=timezone,name,currency,coords") else {
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
            self.getImageByCode(code: response.statusCode)
            print(response)
            do {
                let towns = try JSONDecoder().decode([Town].self, from: data)
                print(towns)
                completion(towns)
            } catch {
                print(error)
            }
        }.resume()
    }
    
    func getImageByCode(code: Int) {
        guard let url = URL(string: "https://http.cat/\(code)") else {
            return
        }
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data else {
                return
            }
            print(data)
            print(response)
        }.resume()
    }
    
}

