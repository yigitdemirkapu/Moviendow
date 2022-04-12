//
//  MovieDetailViewController.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 10.04.2022.
//

import UIKit

final class MovieDetailViewController: BaseViewController {
    // MARK - IBOutlets
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var publishYearLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var imdbIdLabel: UILabel!
    
    // MARK - Properties
    override class var storyboard: String { return K.Storyboard.movie }
    var coordinator: MainCoordinator?
    var viewModel: MovieDetailViewModel?
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK - Helpers
    private func configureUI() {
        guard let viewModel = viewModel else {
            return
        }
        if let movie = viewModel.movie {
            imageView.sd_setImage(with: viewModel.createUrl(from: movie.imageUrlStr), placeholderImage: UIImage(systemName: "film"))
            nameLabel.text = movie.name
            publishYearLabel.text = K.MovieDetailViewController.getPublichYear(movie.year)
            typeLabel.text = K.MovieDetailViewController.getType(movie.type)
            imdbIdLabel.text = K.MovieDetailViewController.getImdbId(movie.imdbID)
        }
    }
}
