//
//  MoviesViewController.swift
//  Moviendow
//
//  Created by Yigit Demirkapu on 10.04.2022.
//

import UIKit
import FirebaseAnalytics

final class MoviesViewController: BaseViewController {
    // MARK - IBOutlets
    @IBOutlet weak var indicatorContainer: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var noDataFoundView: UIView!
    @IBOutlet weak var searchButton: UIButton! {
        didSet {
            searchButton.isEnabled = false
        }
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK - Properties
    override class var storyboard: String { return K.Storyboard.movie }
    var coordinator: MainCoordinator?
    var viewModel: MoviesViewModel?
    var movieList: [Movie]?
    
    // MARK - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK - Helpers
    private func configureUI() {
        searchTextField.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: K.movieCellReuseIdentifier, bundle: nil), forCellWithReuseIdentifier: K.movieCellReuseIdentifier)
    }
    private func showLoading() {
        indicatorView.startAnimating()
        indicatorContainer.isHidden = false
        collectionView.isHidden = true
        noDataFoundView.isHidden = true
    }
    private func hideLoading() {
        self.indicatorView.stopAnimating()
        self.indicatorContainer.isHidden = true
    }
    // MARK - IBActions
    @IBAction func searchButtonDidTapped(_ sender: UIButton) {
        if let keyword = searchTextField.text,
           let viewModel = viewModel {
            showLoading()
            viewModel.fetchMovies(keyword: keyword, completion: { [weak self] movieResponseModel in
                guard let self = self else { return }
                self.hideLoading()
                self.movieList = movieResponseModel.movies
                self.collectionView.reloadData()
                if let movieList = self.movieList,
                   movieList.count > 0 {
                    self.noDataFoundView.isHidden = true
                    self.collectionView.isHidden = false
                } else {
                    self.noDataFoundView.isHidden = false
                    self.collectionView.isHidden = true
                }
            })
        }
    }
}

// MARK: UICollectionViewDelegate
extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movieList?[indexPath.row] {
            Analytics.logEvent("movie_details_opened", parameters: [
                "name": movie.name ?? "" as NSObject
            ])
            coordinator?.goToMovieDetail(with: movie)
        }
    }
}

// MARK: UICollectionViewDataSource
extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: K.movieCellReuseIdentifier, for: indexPath) as! MovieCollectionViewCell
        if let movie = movieList?[indexPath.row],
           let url = URL(string: movie.imageUrlStr ?? "") {
            let cellData = MovieCollectionViewCellData(year: movie.year, type: movie.type, imageUrl: url)
            cell.set(with: cellData)
        }
        return cell
    }
}

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.size.width - 10) / 2
        let height = width * 1.2
        return CGSize(width: width, height: height)
    }
}

extension MoviesViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString =
            currentString.replacingCharacters(in: range, with: string) as NSString
        if String(newString).count > 2 {
            searchButton.isEnabled = true
        } else {
            searchButton.isEnabled = false
        }
        return true
    }
}
