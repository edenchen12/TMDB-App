//
//  MovieTableViewCell.swift
//  TMDB App
//
//  Created by Eden Chen on 10/12/2021.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

	@IBOutlet weak var movieImage: UIImageView!
	@IBOutlet weak var titleLabel: UILabel!
	
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        

    }
    
}
