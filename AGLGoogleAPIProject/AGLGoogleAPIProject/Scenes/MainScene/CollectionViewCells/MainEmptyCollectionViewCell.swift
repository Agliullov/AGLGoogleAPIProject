//
//  MainEmptyCollectionViewCell.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 07.02.2023.
//

import UIKit

final class MainEmptyCollectionViewCell: UICollectionViewCell {
    
    private let centerTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Для начала просмотра начните вводить текст"
        label.textColor = .label
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.preferredFont(forTextStyle: .headline)
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
        self.backgroundColor = UIColor.secondarySystemGroupedBackground
        self.backgroundColor = .clear
        
        self.addSubview(centerTextLabel)
        
        NSLayoutConstraint.activate([
            centerTextLabel.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor),
            centerTextLabel.leadingAnchor.constraint(equalTo: self.layoutMarginsGuide.leadingAnchor),
            self.layoutMarginsGuide.trailingAnchor.constraint(equalTo: centerTextLabel.trailingAnchor),
            self.layoutMarginsGuide.bottomAnchor.constraint(equalTo: centerTextLabel.bottomAnchor)
        ])
    }
}
