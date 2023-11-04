//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/4/23.
//

import UIKit

/// Cell to Display Character Data in ChraterCollectionView
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - UI Elements
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.backgroundColor = .orange
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  MARK: - Init Cell
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setViewsAndConstrains()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        characterImageView.image = nil
        characterNameLabel.text = nil
        characterStatusLabel.text = nil
    }
    
    func configureCell(with viewModel: RMCharacterCollectionViewCellViewModel) {
        characterNameLabel.text = viewModel.characterName
        characterStatusLabel.text = viewModel.getCharacterStatus
        viewModel.fetchImage(completion: { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.characterImageView.image = UIImage(data: image)
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        })
    }
}

extension RMCharacterCollectionViewCell {
    
    //  MARK: - Private Functions
    
    private func setViewsAndConstrains() {
        contentView.addSubViews(characterImageView, characterNameLabel, characterStatusLabel)
        
        NSLayoutConstraint.activate([
            
            characterStatusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterStatusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterStatusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            characterStatusLabel.heightAnchor.constraint(equalToConstant: 45),
            
            
            characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterNameLabel.bottomAnchor.constraint(equalTo: characterStatusLabel.topAnchor, constant: -3),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 45),
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -13)
            
        ])

    }
    
}
