//
//  TableViewCell.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var viewModel: MovieCellViewModel?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewModel?.cancelDataLoad()
        movieImageView.image = nil
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(with viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        viewModel.delegate = self
        viewModel.loadData()
        
        movieTitleLabel.text = viewModel.movieTitle
        ratingLabel.text = viewModel.ratingText
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension TableViewCell: MovieCellViewModelDelegate {
    func didLoad(image: UIImage?) {
        movieImageView.image = image
    }
    
    
}
