//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by J on 5/21/23.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case PopularMovies = 2
    case UpcomingMovies = 3
    case TopRatedMovies = 4
    
}

class HomeViewController: UIViewController {
    
    private var randomTrendingMovie: Title?
    private var headerView: HeroHeaderUIView?
    
    let sectionTitles: [String] = ["Trending Movies",  "Trending Tv", "Popular", "Upcoming Movies", "Top Rated"]
    
    private let homeFeedTable: UITableView = {
        
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        view.addSubview(homeFeedTable)
        
        homeFeedTable.delegate = self
        homeFeedTable.dataSource = self
        
        configureNavbar()
        
        headerView = HeroHeaderUIView(frame: CGRect(x: 0,y:0, width: view.bounds.width, height: 500))
        homeFeedTable.tableHeaderView = headerView
        
        configureHeroHeaderView()
                        
    }
    
    private func configureHeroHeaderView() {
        APICaller.shared.getTrendingMovies { [weak self] result in
            switch result {
            case .success(let titles):
                let randomTitle = titles.randomElement()
                
                self?.randomTrendingMovie = randomTitle
                self?.headerView?.configure(with: TitleViewModel(titleName: randomTitle?.original_name ?? randomTitle?.original_title ?? "Unknown Title", posterURL: randomTitle?.poster_path ?? ""))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func configureNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        self.title = "Netflix Clone"
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        switch indexPath.section {
            case Sections.TrendingMovies.rawValue:
                APICaller.shared.getTrendingMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.TrendingTv.rawValue:
                APICaller.shared.getTrendingTv { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.PopularMovies.rawValue:
                APICaller.shared.getPopularMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.UpcomingMovies.rawValue:
                APICaller.shared.getComingSoonMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.TopRatedMovies.rawValue:
                APICaller.shared.getTopRatedMovies { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            default:
                return UITableViewCell()
            }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y + 20, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        
        let headerTitle = header.textLabel?.text?.capitalizeAbbreviations(str: (header.textLabel?.text)!)
        header.textLabel?.text = headerTitle
    }
    
    // custom Navbar behavior - navbar disappears when scroll down, sticks to the top when pull down
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}


extension HomeViewController: CollectionViewTableViewCellDelegate {
    
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        
        DispatchQueue.main.async {[weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    
    }
}
