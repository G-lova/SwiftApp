//
//  ContentView.swift
//  Project2
//
//  Created by User on 24.01.2024.
//

import SwiftUI

struct News: Codable {
    let results: [Article]
}

struct Article: Codable {
    let title: String
    let publication_date: Int
}

struct ContentView: View {
    @State private var articles: [Article] = []
    @State private var showingNewList = false
    
    var body: some View {
        NavigationView {
            VStack {
                Button("Get news") {
                    fetchNews()
                    self.showingNewList = true
                } .sheet(isPresented: $showingNewList) {
                    NewListView(articles: articles)
                }
            }
        }
    }
    
    func fetchNews() {
        guard let url = URL(string: "https://kudago.com/public-api/v1.4/news/?actual_only=true") else {
            print("Invalid URL")
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                if let decodedResponse = try? JSONDecoder().decode(News.self, from: data) {
                    DispatchQueue.main.async {
                        self.articles = decodedResponse.results
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }.resume()
    }
}

struct  NewListView: View {
    let articles: [Article]
    
    var body: some View {
        List(articles, id: \.title) { article in
            let date = Date(timeIntervalSince1970: TimeInterval(article.publication_date))
            VStack(alignment: .leading) {
                Text(article.title)
                Text("\(date)").foregroundColor(.gray)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
