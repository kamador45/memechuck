//
//  ContentView.swift
//  Prueba
//
//  Created by Kevin Amador Rios on 9/27/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var fetcherData = FetchMemes()
    let meme = FetchMemes()
    @State var disabled:Bool = false
    
    
    var body: some View {
        NavigationView {
            ScrollView {
                if fetcherData.isDownloading == false {
                    Text("Start Download")
                } else {
                    ListMemeView(memex: meme.memesArray)
                }
            }
            .navigationTitle("MemesList")
            .toolbar {
                Button("Download Memes") {
                    fetcherData.fetchMemes { x in
                        meme.memesArray.append(x!)
                    }
                    disabled = true
                }.disabled(disabled)
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
