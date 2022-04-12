//
//  Constants.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 9.04.2022.
//

import Foundation

struct K {
    static let baseUri = "http://www.omdbapi.com/?apikey=<INSERT YOUR API KEY HERE>"
    static let movieCellReuseIdentifier = "MovieCollectionViewCell"
    
    struct StoryboardIdentifier {
        static let splashViewController = "SplashViewController"
        static let moviesViewController = "MoviesViewController"
        static let movieDetailViewController = "MovieDetailViewController"
    }
    
    struct Storyboard {
        static let movie = "Movie"
    }
    
    struct MovieDetailViewController {
        static func getPublichYear(_ year: String?) -> String {
            return "Publish Year: \(year ?? "")"
        }
        static func getType(_ type: String?) -> String {
            return "Type: \(type ?? "")"
        }
        static func getImdbId(_ imdbId: String?) -> String {
            return "IMDB ID: \(imdbId ?? "")"
        }
    }
    
}
 
