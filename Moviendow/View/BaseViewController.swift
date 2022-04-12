//
//  BaseViewController.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 9.04.2022.
//

import UIKit

class BaseViewController: UIViewController {
    class var storyboard: String {
        return ""
    }
    func showAlert(title: String, message: String, actionTitle: String, completion: @escaping ()->()) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: actionTitle, style: .default, handler: { _ in
            alert.dismiss(animated: true) {
                completion()
            }
        }))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: Storyboarded
extension BaseViewController: Storyboarded {
    static func instantiate() -> Self {
        let storyboardIdentifier = String(describing: self)
        let storyboard = UIStoryboard(name: Self.storyboard, bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: storyboardIdentifier) as! Self
    }
}
