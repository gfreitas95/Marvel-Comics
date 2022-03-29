//
//  HomeView.swift
//  MarvelComics
//
//  Created by Gustavo Freitas on 28/03/22.
//

import UIKit

class HomeView: UIViewController, UISearchBarDelegate {
    
    private var characters: [Character] = []
    private let searchController = UISearchController()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .systemBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DescriptionView.self, forCellReuseIdentifier: DescriptionView.identifier)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - SetupLayout
    
    func setupLayout() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        title = "Marvel Comics"
        searchController.searchBar.delegate = self
        searchController.searchBar.keyboardType = .alphabet
        searchController.hidesNavigationBarDuringPresentation = false
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.characters.removeAll()
        guard let text = searchController.searchBar.text else { return }
        
        HomeViewModel.shared.fetchCharacterDataWith(name: text) { [weak self] (result) in
            
            switch result {
                
            case .failure(let error):
                print(error.localizedDescription)
                
            case .success(let success):
                self?.characters = success.data.results
                DispatchQueue.main.async {
                    self?.checkSearchResult()
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    func checkSearchResult() {
        if self.characters.isEmpty {
            self.showErrorAlert()
        } 
    }
}

// MARK: - UITableView Delegate / DataSource

extension HomeView: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return !characters.isEmpty ? characters.count : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.size.height * 0.2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: DescriptionView.identifier, for: indexPath) as! DescriptionView
        
        let heroDetail = characters[indexPath.row]
        let thumbnail = heroDetail.thumbnail
        let path = thumbnail["path"] ?? ""
        let ext = thumbnail["extension"] ?? ""
        cell.configureWith(name: heroDetail.name, description: heroDetail.description, path: path, ext: ext)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let characterInfoView = CharacterInfoView()
        let heroDetail = characters[indexPath.row]
        let thumbnail = heroDetail.thumbnail
        let path = thumbnail["path"] ?? ""
        let ext = thumbnail["extension"] ?? ""
        characterInfoView.configureWith(data: heroDetail.thumbnail, title: heroDetail.name, description: heroDetail.description, path: path, ext: ext)
        self.navigationController?.pushViewController(characterInfoView, animated: true)
    }
}
