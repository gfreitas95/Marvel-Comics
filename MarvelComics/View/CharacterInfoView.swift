//
//  CharacterInfoView.swift
//  MarvelComics
//
//  Created by Gustavo Freitas on 28/03/22.
//

import UIKit
import SDWebImage

class CharacterInfoView: UIViewController {
    
    private let infoViewImage: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .center
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    // MARK: - GetCharacterInfo
    
    func configureWith(data: [String : String], title: String, description: String, path: String, ext: String) {
        self.title = title
        self.descriptionLabel.text = description
        let path = data["path"] ?? ""
        let ext = data["extension"] ?? ""
        let url = URL(string: "\(path).\(ext)")
        self.infoViewImage.sd_setImage(with: url)
        self.infoViewImage.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    // MARK: - SetupLayout
    
    func setupLayout() {
        view.addSubview(infoViewImage)
        view.addSubview(descriptionLabel)
        view.backgroundColor = .systemBackground
        let imageSize: CGFloat = view.frame.size.height * 0.5
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NSLayoutConstraint.activate([
            infoViewImage.heightAnchor.constraint(equalToConstant: imageSize),
            infoViewImage.topAnchor.constraint(equalTo: view.topAnchor, constant: -20),
            infoViewImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            infoViewImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            descriptionLabel.topAnchor.constraint(equalTo: infoViewImage.bottomAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            descriptionLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
