//
//  MoviesViewModel.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 10.04.2022.
//

import Foundation

struct MoviesViewModel {
    func fetchMovies(keyword: String, completion: @escaping (MovieResponseModel) -> Void) {
        guard let url = URL(string: "\(K.baseUri)\(keyword)") else { return }
        NetworkManager.shared.fetch(from: url, completion: completion)
    }
}
