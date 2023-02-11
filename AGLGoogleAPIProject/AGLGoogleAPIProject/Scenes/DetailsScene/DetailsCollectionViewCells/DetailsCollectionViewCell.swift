//
//  DetailsCollectionViewCell.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 09.02.2023.
//

import UIKit

final class DetailsCollectionViewCell: UICollectionViewCell {
        
    var leftSideButtonTapped: (() -> Void)?
    var rightSideButtonTapped: (() -> Void)?
    
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
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private let leftSideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondaryLabel
        button.layer.cornerRadius = 6.0
        button.layer.masksToBounds = true
        button.setTitle("Prev", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        return button
    }()
    
    private let rightSideButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .secondaryLabel
        button.layer.cornerRadius = 6.0
        button.layer.masksToBounds = true
        button.setTitle("Next", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .body)
        return button
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
        leftSideButton.addTarget(self, action: #selector(leftButtonDidTap), for: .touchUpInside)
        rightSideButton.addTarget(self, action: #selector(rightButtonDidTap), for: .touchUpInside)
        
        contentView.addSubview(activityIndicatorView)
        contentView.addSubview(imageView)
        contentView.addSubview(leftSideButton)
        contentView.addSubview(rightSideButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: imageView.trailingAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            activityIndicatorView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicatorView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            leftSideButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor, constant: 30.0),
            leftSideButton.heightAnchor.constraint(equalToConstant: 50.0),
            leftSideButton.widthAnchor.constraint(equalToConstant: 100.0),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: leftSideButton.bottomAnchor, constant: 30.0),
            
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: rightSideButton.trailingAnchor, constant: 30.0),
            rightSideButton.heightAnchor.constraint(equalToConstant: 50.0),
            rightSideButton.widthAnchor.constraint(equalToConstant: 100.0),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: rightSideButton.bottomAnchor, constant: 30.0)
        ])
    }
    
    @objc private func leftButtonDidTap() {
        leftSideButtonTapped?()
    }
    
    @objc private func rightButtonDidTap() {
        rightSideButtonTapped?()
    }
}

extension DetailsCollectionViewCell {
    func setup(imageURL: URL?) {
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
