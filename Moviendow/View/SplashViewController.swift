//
//  SplashViewController.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 9.04.2022.
//

import UIKit
import Firebase

final class SplashViewController: BaseViewController {
    // MARK - IBOutlets
    @IBOutlet weak var welcomeLabel: UILabel! {
        didSet {
            welcomeLabel.alpha = 0
        }
    }
    // MARK - Properties
    override class var storyboard: String { return K.Storyboard.movie }
    var coordinator: MainCoordinator?
    let remoteConfig = RemoteConfig.remoteConfig()
    var welcomeMessage: String? {
        didSet {
            welcomeLabel.text = welcomeMessage
            UIView.animate(withDuration: 3, delay: 0, options: .transitionCrossDissolve, animations: {
                self.welcomeLabel.alpha = 1
            }) { _ in
                UIView.animate(withDuration: 3, delay: 0, options: .transitionCrossDissolve, animations: {
                    self.welcomeLabel.alpha = 0
                }) { _ in
                    self.coordinator?.goToMovies()
                }
            }
        }
    }
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    // MARK - Helpers
    private func configureUI() {
        if NetworkManager.shared.isConnectedToTheInternet() {
            fetchRemoteConfig()
        } else {
            showAlert(title: "Connection error",
                      message: "Internet connection cannot be established. Make sure you are connected to the internet, and try again.",
                      actionTitle: "Try again") { [weak self] in
                self?.configureUI()
            }
        }
    }
    private func fetchRemoteConfig() {
        remoteConfig.fetch { [weak self] status, error in
            guard let self = self else { return }
            if status == .success {
                self.welcomeMessage = self.remoteConfig.configValue(forKey: "welcomeText").stringValue
            } else {
                print("Error while fetching configs: \(error?.localizedDescription ?? "No error available.")")
            }
        }
    }
}
