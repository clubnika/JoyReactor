//
//  ContentView.swift
//  JoyReactor
//
//  Created by Морозов Иван on 08.04.2022.
//

import SwiftUI
import SwiftSoup
import Kingfisher

struct ContentView: View {
    
    @State var srcsStringArray: [String?] = []
        
    var body: some View {
        ScrollView {
            ForEach(srcsStringArray, id: \.self) { string in
                if let string = string{
                    if let url = URL(string: string){
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
            }
        }
        .onAppear {
            let url = URL(string: "http://joyreactor.cc")!
            let session = URLSession.shared
            let urlRequest = URLRequest(url: url)

            let task = session.dataTask(with: urlRequest) { data, resp, error in
                if let data = data {
                    if let formattedData = String(data: data, encoding: .utf8) {
                        
                        do {
                            let html: String = formattedData
                            let doc: Document = try SwiftSoup.parse(html)
                            let srcs: Elements = try doc.select("img[src]")
                            self.srcsStringArray = srcs.array().map { el in

                                if let url = try? el.attr("src").description{
                                    if url.contains("post"){
                                    print(url)
                                    return url
                                    }
                                }
                                return nil
                            }
                            
            //                print(srcsStringArray)
                            // do something with srcsStringArray
                            
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
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
