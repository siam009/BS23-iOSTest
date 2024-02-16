//
//  MovieListViewModel.swift
//  BS23-iOSTest
//
//  Created by Arnab Ahamed Siam on 15/2/24.
//

import Foundation
import Combine

class MovieListViewModel: ObservableObject {
    
    @Published var movies = [Movie]()
    @Published var searchQuery = "marvel"
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $searchQuery.sink { [weak self] updatedString in
            guard let thisSelf = self else {
                return
            }
            thisSelf.getMovieList(query: updatedString)
        }
        .store(in: &cancellables)
    }
    
    private func getMovieList(query: String) {
        guard let endPoint = getEndpoint(using: query) else {
            print("couldn't create a valid endpoint")
            return
        }
        
        WebService.sendRequest(endPoint: endPoint, responseModel: MovieList.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let movieList):
                    if let movies = movieList.results {
                        self.movies = movies
                    } else {
                        print("no data found")
                    }
                case .failure(let failure):
                    print("failed to get data \(failure)")
                }
            }
        }
    }
    
    private func getEndpoint(using query: String) -> EndPoint? {
        let encodedQuery = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let apiKey = Constant.API.apiKey
        let apiEndPoint = Constant.API.apiEndPoint
        
        let searchURLString = apiEndPoint + apiKey + "&query=" + encodedQuery
        
        guard let url = URL(string: searchURLString) else {
            return nil
        }
        
        let endPoint = EndPoint(url: url, httpMethod: .get, httpBody: nil)
        return endPoint
    }
    
}
