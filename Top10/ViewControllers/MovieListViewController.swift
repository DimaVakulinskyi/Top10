//
//  ViewController.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import UIKit

class MovieListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var selectedTitle: String?
    let viewModel = MovieListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = viewModel.title
        
        tableView.dataSource = self
        tableView.delegate = self
        
        viewModel.delegate = self
        viewModel.loadData()
    }
}

extension MovieListViewController: MovieListViewModelDelegate {
    func didLoadData() {
        tableView.reloadData()
    }
}

extension MovieListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell = tableView.cellForRow(at: indexPath) as? TableViewCell
        let selectedTitle = selectedCell?.viewModel?.movieTitle
        tableView.deselectRow(at: indexPath, animated: true)
        
        showDetailsViewController(with: selectedTitle)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func showDetailsViewController(with title: String?) {
        guard let destinationVC = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else {
            return
        }
        
        destinationVC.titleLabelText = title
        navigationController?.pushViewController(destinationVC, animated: true)
    }
}


extension MovieListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        
        let movie = viewModel.movies[indexPath.row]
        let viewModel = MovieCellViewModel(movie: movie)
        cell.configure(with: viewModel )
        
        return cell
    }
    
}
