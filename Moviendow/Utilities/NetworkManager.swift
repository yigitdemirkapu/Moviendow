//
//  NetworkManager.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 9.04.2022.
//

import UIKit
import Alamofire

struct Connectivity {
  static let sharedInstance = NetworkReachabilityManager()!
  static var isConnectedToInternet:Bool {
      return self.sharedInstance.isReachable
    }
}

struct NetworkManager {
    static let shared = NetworkManager()
    
    private init() {
        
    }
    
    func fetch<T: Codable>(from url: URL, completion: @escaping (T) -> Void) {
        AF.request(url)
          .validate()
          .responseDecodable(of: T.self) { response in
              if let error = response.error {
                  print("ERROR: \(error.errorDescription ?? "")")
              } else if let response = response.value {
                  completion(response)
              } else {
                  print("ERROR while decoding")
              }
          }
    }
    
    func isConnectedToTheInternet() -> Bool {
        Connectivity.isConnectedToInternet
    }
}
