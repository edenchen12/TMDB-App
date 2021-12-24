//
//  ViewController.swift
//  TMDB App
//
//  Created by Eden Chen on 09/12/2021.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
				
		tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
		tableView.dataSource = self
		tableView.delegate = self
		
	}

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
	
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
	
		cell.titleLabel.text = "Spider-Man"
		if #available(iOS 13.0, *) {
			cell.movieImage.image = UIImage(systemName: "person")
		} else {
			// Fallback on earlier versions
		}
		
		return cell
	}
	
}

