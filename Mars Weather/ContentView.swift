//
//  ContentView.swift
//  Mars Weather
//
//  Created by ira on 16.06.2021.
//

import SwiftUI

struct ContentView: View {
    let urlPics = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=3xRVKt4v1k0hejRdut4kGGB5c1vg5drQBIY63hZh"
    @State var tmp: String?
    
    var body: some View {
        ZStack {
            Image("test")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .colorMultiply(Color(red: 250.0, green: 1.0, blue: 100.0, opacity: 0.9))
            Text(tmp ?? "no")
            
            
        }.onAppear {
            fetchin(completion: { string in
                self.tmp = string
            })
        }
    }
    
    func fetchin(completion: @escaping (String) -> ()) {
        let url = URL(string: urlPics)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            do {
                if let json = try? JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as? [String : AnyObject] {
                    let photos = json["photos"] as? [AnyObject]
                    for obj in photos! {
                        if let img = obj["img_src"] {
                            completion(img as! String)
                        }
                    }
//                    if let str = photos!["img_src"] as? String {
//                        completion(str)
//                    }
//                    let str = photos!["img_src"] as? String
//                    completion(str!)
                }
            }
        }
        task.resume()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
