//
//  DescriptionView.swift
//  MarvelComics
//
//  Created by Gustavo Freitas on 28/03/22.
//

import UIKit
import SDWebImage

final class DescriptionView: UITableViewCell {
    
    static let identifier = "DescriptionView"
    
    private let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .black
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.font = .boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let descriptionLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .gray
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterPhoto: UIImageView = {
       let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(characterPhoto)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        nameLabel.text = nil
        descriptionLabel.text = nil
        characterPhoto.image = nil
    }
    
    func configureWith(name: String, description: String, path: String, ext: String) {
        self.nameLabel.text = name
        self.descriptionLabel.text = description
        let url = URL(string: "\(path).\(ext)")
        self.characterPhoto.sd_setImage(with: url)
        self.characterPhoto.sd_imageIndicator = SDWebImageActivityIndicator.gray
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageWidth: CGFloat = contentView.frame.size.width * 0.4
        let labelHeight: CGFloat = contentView.frame.size.width * 0.1
        
        NSLayoutConstraint.activate([
            characterPhoto.widthAnchor.constraint(equalToConstant: imageWidth),
            characterPhoto.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            characterPhoto.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            characterPhoto.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            
            nameLabel.heightAnchor.constraint(equalToConstant: labelHeight),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: characterPhoto.trailingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: characterPhoto.trailingAnchor, constant: 10),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ])
    }
}
