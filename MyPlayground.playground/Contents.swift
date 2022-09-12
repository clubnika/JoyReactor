import UIKit
//import SwiftSoup

struct PostModel {

    var text: String? = nil
    var imageURL: [String]? = nil
    
}

let url = URL(string: "http://joyreactor.cc")!
let session = URLSession.shared
let urlRequest = URLRequest(url: url)

//let task = session.dataTask(with: urlRequest) { data, resp, error in
//    if let data = data {
//        if let formattedData = String(data: data, encoding: .utf8) {
//
//            do {
//                let html: String = formattedData
//                let doc: Document = try SwiftSoup.parse(html)
////                let nextNext: Elements = try doc.getElementsByClass("next")
////                let text = try nextNext.attr("href")
//                let next = try doc.getElementsByClass("next").attr("href")
//                print(next)
//
//                let postContainer: Elements = try doc.getElementsByClass("postContainer")
//
//                for post in postContainer {
//                    var model = PostModel()
//
//                    //пробуем достать описание поста
//                    if let text = try? post.getElementsByClass("post_content").text() {
//                        model.text = text
//                    }
//
//                    //пробудем достать картинку (картинки)
//                    if let image = try? post.getElementsByClass("image") {
//                        model.imageURL = try? image.array().map({ element in
//                            return try? element.select("img").attr("src")
//                        }) as! [String]
////                        print("-----------------image----------------")
////                        image.select("src")
//                    }
////                    print(text)
//
//                }
////                let srcs: Elements = try doc.select("img[src]")
////                let srcsStringArray: [String?] = srcs.array().map { el in
////
////                    if let url = try? el.attr("src").description{
////                        if url.contains("post"){
////                        print(url)
////                        return url
////                        }
////                    }
////                    return nil
////                }
//
////                print(srcsStringArray)
//                // do something with srcsStringArray
//
//            } catch Exception.Error(let type, let message) {
//                print(message)
//            } catch {
//                print("error")
//            }
//
//        }
//    }
//    if let error = error{
//        print(error)
//    }
//}

//task.resume()


struct Foo {
    var name: String
    var age: Foo
    struct Foo{
        var age: Int
        var sex: Foo
        struct Foo {
            enum Sex{
                case m, w
            }
            
            var sex: Sex
        }
    }
}

var foo: Foo = Foo(name: "Foo", age: Foo.Foo(age: 12, sex: Foo.Foo.Foo(sex: .m)))

var liseFoo = [foo,foo,foo,foo]


