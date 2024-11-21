//
//  ButtonCollectionViewCell.swift
//  InfiniteScroll
//
//  Created by Bianca Curutan on 11/20/24.
//

import UIKit

class ButtonCollectionViewCell: UICollectionViewCell {

    var text: String? {
        didSet {
            button.setTitle(text, for: .normal)
        }
    }

    var buttonTapHandler: (() -> Void)?

    private var button: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 8, bottom: 8, trailing: 8)
        
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.backgroundColor = .lightGray
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", for: .normal)
        button.setTitleColor(.black, for: .normal)

//        button.titleLabel?.lineBreakMode = .byWordWrapping
//        button.titleLabel?.numberOfLines = 1

        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: contentView.topAnchor),
            button.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            contentView.bottomAnchor.constraint(equalTo: button.bottomAnchor),
            contentView.rightAnchor.constraint(equalTo: button.rightAnchor),
            button.heightAnchor.constraint(equalToConstant: 40)
        ])

        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func buttonTapped() {
        buttonTapHandler?()
    }
}
