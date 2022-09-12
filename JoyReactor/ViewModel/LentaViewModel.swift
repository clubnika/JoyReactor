//
//  LentaViewModel.swift
//  JoyReactor
//
//  Created by Морозов Иван on 03.05.2022.
//

import SwiftUI
import SwiftSoup

class LentaViewModel: ObservableObject {

    @Published var postList: [PostModel] = []
    var nextPage: String? = nil
    
    init () {
        fetchPosts()
    }
    
    func fetchPosts() {
        request()
    }

    func fetchNextPosts(){
        request(page: nextPage)
    }
    
    private func request(page: String? = nil) {
        
        var urlString = "http://joyreactor.cc"
        if let page = page {
            urlString += page
        }
        let url = URL(string: urlString)!
        let session = URLSession.shared
        let urlRequest = URLRequest(url: url)
        
        let task = session.dataTask(with: urlRequest) { data, resp, error in
            if let data = data {
                if let formattedData = String(data: data, encoding: .utf8) {
                    
                    do {
                        let html: String = formattedData
                        let doc: Document = try SwiftSoup.parse(html)
                        let next = try doc.getElementsByClass("next").attr("href")
                        self.nextPage = next
                        print(next)
                        
                        let postContainer: Elements = try doc.getElementsByClass("postContainer")
                        
                        for post in postContainer {
                            var model = PostModel()
                            
                            //пробуем достать описание поста
                            if let text = try? post.getElementsByClass("post_content").text() {
                                model.text = text
                            }
                            
                            //пробудем достать картинку (картинки)
                            if let image = try? post.getElementsByClass("image") {
//                                print(try? image.html(), "✅")
                                model.imageURLs = try? image.array().map({ element -> String in
                                    let url = try? element.select("img").attr("src") as String
                                    
                                    return "https:" + url!
                                }) as! [String]
                            }
                            DispatchQueue.main.async {
                                self.postList.append(model)
                            }
                        }
                        
                    } catch Exception.Error(let type, let message) {
                        print(message)
                    } catch {
                        print("error")
                    }
                    
                }
            }
            if let error = error{
                print(error)
            }
        }
        task.resume()
    }
}

