//
//  MovieListView.swift
//  BS23-iOSTest
//
//  Created by Arnab Ahamed Siam on 15/2/24.
//

import SwiftUI

struct MovieListView: View {
    
    @ObservedObject var viewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.movies) { movie in
                HStack {
                    AsyncImage(url: viewModel.getPosterURL(data: movie)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 120)
                    } placeholder: {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 120)
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.title)
                            .font(.headline)
                        Text(movie.overview)
                            .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .padding(EdgeInsets(top: 8, leading: 0, bottom: 0, trailing: 0))
                }
                .alignmentGuide(.listRowSeparatorLeading, computeValue: { dimension in
                    return 0
                })
                
            }
            .searchable(text: $viewModel.searchQuery)
            .listStyle(.plain)
            .navigationTitle("Movie List")
        }
    }
}


#Preview {
    MovieListView(viewModel: MovieListViewModel())
}
