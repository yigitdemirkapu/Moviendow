//
//  MainCoordinator.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 9.04.2022.
//

import UIKit

final class MainCoordinator: Coordinator {
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController = UINavigationController()) {
        self.navigationController = navigationController
        navigationController.navigationBar.isHidden = true
    }
    
    func start() {
        let splashVC = SplashViewController.instantiate()
        splashVC.coordinator = self
        navigationController.setViewControllers([splashVC], animated: false)
    }
    
    func goToMovies() {
        let moviesVC = MoviesViewController.instantiate()
        moviesVC.coordinator = self
        let moviesViewModel = MoviesViewModel()
        moviesVC.viewModel = moviesViewModel
        navigationController.pushViewController(moviesVC, animated: false)
    }
    
    func goToMovieDetail(with movie: Movie?) {
        let movieDetailVC = MovieDetailViewController.instantiate()
        movieDetailVC.coordinator = self
        var movieDetailViewModel = MovieDetailViewModel()
        movieDetailViewModel.movie = movie
        movieDetailVC.viewModel = movieDetailViewModel
        navigationController.pushViewController(movieDetailVC, animated: true)
    }
}
