//
//  MovieListView.swift
//  BS23-iOSTest
//
//  Created by Arnab Ahamed Siam on 15/2/24.
//

import SwiftUI

struct MovieListView: View {
    
    let str = ["a", "b", "c", "d", "e", "f", "g", "h", "a", "b", "c", "d", "a", "b", "c", "d", "a", "b", "c", "d"]
    
    @State private var queryText = "marvel"
    
    var body: some View {
        NavigationView {
            List(str, id: \.self) { data in
                HStack {
                    Image(systemName: "photo")
                        .frame(width: 100, height: 150)
                        .scaledToFill()
                    
                    VStack {
                        Text(data)
                            .font(.subheadline)
                        Text(data)
                    }
                }
            }
            .searchable(text: $queryText)
            .navigationTitle("Movie List")
        }
    }
}

#Preview {
    MovieListView()
}
