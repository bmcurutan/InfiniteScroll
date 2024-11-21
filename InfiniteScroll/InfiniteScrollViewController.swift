//
//  ViewController.swift
//  InfiniteScroll
//
//  Created by Bianca Curutan on 11/20/24.
//

import UIKit

// TODO Make it infinite
// TODO Fix horizontal spacing

class InfiniteScrollViewController: UIViewController {

    let items: [String] = [
        "1 Who is the actress that portrays Lidia Poet?",
        "2 What is the ideal thermostate temperature for winter?",
        "3 What is the capital of Indonesia?",
        "4 How many countries are there in the world?",
        "5 When was the first masquerade ball?",
        "6 What is the name of the famous French chef?",
        "7 How many Italian dialects are there?",
        "8 Who discovered the atom?",
        "9 When does the next season of My Happy Marriage come out?",
        "10 How far is the moon from Earth?",
        "11 What do you call a group of cats?",
        "12 How many feet are in a mile?",
        "13 Who wrote \"The Nightmare Before Christmas\"?",
        "14 How do you explain Git to a programming beginner?",
        "15 What are the 100 most popular cat names?"
    ].shuffled()

    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 8 // Space between rows
        layout.minimumInteritemSpacing = 8 // Space between items in a row
        layout.scrollDirection = .horizontal

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let resultLabel: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ButtonCollectionViewCell.self, forCellWithReuseIdentifier: "ButtonCollectionViewCell")

        let numberOfRows = 1
        let heightConstant = (40 * numberOfRows) + (8 * (numberOfRows - 1))
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.rightAnchor.constraint(equalTo: collectionView.rightAnchor),
            collectionView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: CGFloat(heightConstant))
        ])

        view.addSubview(resultLabel)
        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 24),
            resultLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24),
            view.rightAnchor.constraint(equalTo: resultLabel.rightAnchor, constant: 24)
        ])

        startAutoScroll()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopAutoScroll()
    }

    func startAutoScroll() {
        timer = Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    func stopAutoScroll() {
        timer?.invalidate()
        timer = nil
    }

    @objc func autoScroll() {
        let currentOffset = collectionView.contentOffset.x
        let newOffset = CGPoint(x: currentOffset + 1, y: 0)

        if newOffset.x > collectionView.contentSize.width - collectionView.bounds.width {
//            collectionView.contentOffset = .zero // Reset to the beginning
        } else {
            collectionView.setContentOffset(newOffset, animated: false)
        }
    }
}

extension InfiniteScrollViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCollectionViewCell", for: indexPath) as? ButtonCollectionViewCell else { return UICollectionViewCell() }
        cell.text = items[indexPath.item]
        cell.buttonTapHandler = { [weak self] in
            self?.resultLabel.text = cell.text
        }
        return cell
    }
}

extension InfiniteScrollViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let text = items[indexPath.item]
        let textWidth = text.size(withAttributes: [.font: UIFont.systemFont(ofSize: 15)]).width

//        print(textWidth)

        return CGSize(width: textWidth + 16, height: 40) // Add padding
    }
}
