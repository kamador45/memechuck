//
//  ListMemeView.swift
//  Prueba
//
//  Created by Kevin Amador Rios on 9/27/22.
//

import SwiftUI

struct ListMemeView: View {
    let memex:[MemesModel]
    
    var body: some View {
        VStack {
            ForEach(memex) { model in
                HStack {
                    ImageContainer(imageUrl: model.icon_url)
                    Text(model.value)
                }
            }
        }
    }
}

struct ImageContainer:View {
    var imageUrl: String
    var body: some View {
        AsyncImage(url: URL(string: imageUrl)) { image in
            image.resizable()
        } placeholder: {
            ProgressView()
            Color.gray
        }

    }
}

struct ListMemeView_Previews: PreviewProvider {
    static var previews: some View {
        ListMemeView(memex: [MemesModel]())
    }
}
