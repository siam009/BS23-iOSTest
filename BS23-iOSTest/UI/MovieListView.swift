//
//  MovieListView.swift
//  BS23-iOSTest
//
//  Created by Arnab Ahamed Siam on 15/2/24.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel = MovieListViewModel()
    @State private var queryText = "marvel"
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { data in
                HStack() {
                    Image(systemName: "photo")
                        .frame(width: 100, height: 150)
                        .scaledToFill()
                    
                    VStack(alignment: .center) {
                        Text(data.title)
                            .font(.headline)
                        Text(data.overview)
                    }
                }
            }
            .searchable(text: $viewModel.searchQuery)
            .navigationTitle("Movie List")
        }
    }
}
