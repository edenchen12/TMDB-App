//
//  DetailsViewController.swift
//  TMDB App
//
//  Created by Eden Chen on 18/12/2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var selectedMovie: TMDBMovie?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let selectedMovie = selectedMovie else {
            let alert = UIAlertController(title: "Something went wrong", message: "Something went wrong please try again lateer", preferredStyle: .alert)
            let okButton = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(okButton)
            present(alert, animated: true)
            return
        }
        
        titleLabel.text = selectedMovie.title
        let endPoint = NetworkManager.shared.posterRootURL + selectedMovie.posterPath
        NetworkManager.shared.downloadImage(from: endPoint)
        posterImage.image = NetworkManager.shared.image
        descriptionLabel.text = selectedMovie.overview
    }
    
}
