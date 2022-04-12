//
//  Coordinator.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 9.04.2022.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
