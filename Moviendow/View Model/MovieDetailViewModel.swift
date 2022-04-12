//
//  MovieDetailViewModel.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 10.04.2022.
//

import Foundation

struct MovieDetailViewModel {
    var movie: Movie?
    
    func createUrl(from urlStr: String?) -> URL? {
        return URL(string: urlStr ?? "")
    }
}
