//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by J on 5/21/23.
//

import UIKit

class ComingSoonViewController: UIViewController {
    
    private var titles: [Title] = []
    
    private let comingSoonTable: UITableView = {
        let table = UITableView()
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Coming Soon"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        navigationController?.navigationBar.tintColor = .white

        
        view.addSubview(comingSoonTable)
        comingSoonTable.delegate = self
        comingSoonTable.dataSource = self
        
        fetchUpcoming()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        comingSoonTable.frame = view.bounds
    }
    
    private func fetchUpcoming() {
        APICaller.shared.getComingSoonMovies { [weak self] result in
            switch result {
            case .success(let titles):
                self?.titles = titles
                DispatchQueue.main.async {
                    self?.comingSoonTable.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}

extension ComingSoonViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else {
            return UITableViewCell()
        }
        
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_title ?? title.original_name) ?? "Unkown Title Name", posterURL: title.poster_path ?? "" ))
        
        // dont highlight when clicked
        cell.selectionStyle = .none
        return cell

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let title = titles[indexPath.row]
        
        guard let titleName = title.original_title ?? title.original_name else { return }
        
        APICaller.shared.getYoutubeMovieTrailer(with: titleName) { [weak self] result in
            switch result {
                
            case .success(let videoElement):
                
                DispatchQueue.main.async {
                    let vc = TitlePreviewViewController()
                    vc.configure(with: TitlePreviewViewModel(title: titleName, youtubeView: videoElement, titleOverview: title.overview ?? ""))
                    self?.navigationController?.pushViewController(vc, animated: true)
                }
                
        
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
}
