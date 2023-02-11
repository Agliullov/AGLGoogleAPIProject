//
//  MainCollectionViewCell.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 07.02.2023.
//

import UIKit

final class MainCollectionViewCell: UICollectionViewCell {
    
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(frame: .zero)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.style = .large
        activityIndicator.backgroundColor = .white
        return activityIndicator
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .systemFill
        imageView.layer.cornerRadius = 6.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .label
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont.preferredFont(forTextStyle: .body)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViews()
    }
    
    private func configureViews() {
        self.backgroundColor = .secondarySystemGroupedBackground
        contentView.backgroundColor = .clear
        self.layer.cornerRadius = 6.0
        self.layer.masksToBounds = true
        
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 190),
            imageView.heightAnchor.constraint(equalToConstant: 190),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 4.0),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 21.0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4.0),
            subtitleLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: subtitleLabel.trailingAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: subtitleLabel.bottomAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 21.0),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor)
        ])
    }
}

extension MainCollectionViewCell {
    func setup(_ titleText: String?, _ subtitleText: String?, _ imageURL: URL?) {
        titleLabel.text = titleText
        subtitleLabel.text = subtitleText
        if let imageURL = imageURL {
            activityIndicatorView.startAnimating()
            let _ = ImageLoader.shared.loadImage(from: imageURL).sink { [weak self] image in
                guard let self = self else { return }
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.imageView.image = image
                }
            }
        } else {
            imageView.image = nil
            activityIndicatorView.startAnimating()
        }
    }
}
