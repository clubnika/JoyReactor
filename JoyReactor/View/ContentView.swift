//
//  ContentView.swift
//  JoyReactor
//
//  Created by Морозов Иван on 08.04.2022.
//

import SwiftUI
import Kingfisher
import SDWebImageSwiftUI



struct ContentView: View {
    
    @StateObject var viewModel: LentaViewModel = .init()
    
//    @Environment(\.self) var env - возможность ссылвать на текушее представление и взаимодействовать с ним
//    env.dismiss - можно закрывать текущий экран
    
    @State var columns = [
        GridItem(.adaptive(minimum: 200, maximum: 400)), GridItem(.adaptive(minimum: 150, maximum: 400))
    ]
    @State private var isShareViewPresented: Bool = false
    
    var body: some View {
        
        Button(action: {
            withAnimation(Animation.easeInOut(duration: 0.25)) {
//                self.columns = Array(repeating: .init(.adaptive(minimum: 200, maximum: 400)), count: self.columns.count % 4 + 1)
                
                self.columns = Array(repeating: .init(.flexible()), count: self.columns.count % 4 + 1)

            }
        }) {
            Image(systemName: "square")
                .font(.title)
                .foregroundColor(.primary)
        }
        ScrollViewReader { scroll in

            ScrollView {
                LazyVGrid(columns: columns) {
//                List{
                    ForEach(viewModel.postList) { post in
                        cardPost(post: post)
                            .padding(.vertical)
                            .onTapGesture {
//                                withAnimation(Animation.easeInOut(duration: 0.25)) {
                                    self.columns = Array(repeating: .init(.flexible()), count: 1)
//                                    self.columns = Array(repeating: .init(                                        .adaptive(minimum: 200, maximum: 400)), count: 1)

                                    scroll.scrollTo(post.id)
//                                }
                            }
                    } //ForEach
                } //LazyVGrid
            } //ScrollView
            
//            .onAppear {
//                fetchPosts()
//            }
            
        } //ScrollViewReader
        
    }
    
    @ViewBuilder
    func cardPost(post: PostModel) -> some View {
        
        VStack {
            //            Text(post.id.description)
            
            if let text = post.text {
                Text(text)
            }
            
            if let urls = post.imageURLs{
                ForEach(urls, id: \.self) { url in
                    if let url = URL(string: url){
                        
//                        AsyncImage(url: url) { img in
//                            img
//                                .resizable()
//                                .scaledToFit()
//                                .padding()
//                        } placeholder: {
//                            Text("Гружу")
//                        }

//                        if let image = try? Data(contentsOf: url){
                        
//                        WebImage(url: url)
//                            .resizable()
//                            .scaledToFit()
//                            .padding()
//                            .contextMenu {
//                                Button("поделиться") {
//                                    isShareViewPresented = true
//                                }
//                            }

//                            .onLongPressGesture {
//                                isShareViewPresented = true
//                            } - такой себе вариант, потому что перестает работать скролл
//                            .sheet(isPresented: $isShareViewPresented) {
//                                print("dismiss")
//                            } content: {
//                                ActivityViewController(itemsToShare: [image])
//                            }
                        KFImage(url)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .padding()
//                        }
                    }
                }
            }
        }
        //        .padding()
        .background(
            .ultraThinMaterial
//            Color.gray
//                .opacity(0.2)
//                .overlay(.ultraThinMaterial)
        )
        .cornerRadius(12)

        .onAppear {
            if post == viewModel.postList.last {
                print("last item")
                viewModel.fetchNextPosts()
            }
        }
        
    }
    
    
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

struct ActivityViewController: UIViewControllerRepresentable {

    var itemsToShare: [Any]
    var servicesToShareItem: [UIActivity]? = nil

    func makeUIViewController(context: UIViewControllerRepresentableContext<ActivityViewController>) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: itemsToShare, applicationActivities: servicesToShareItem)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ActivityViewController>) {}

}
