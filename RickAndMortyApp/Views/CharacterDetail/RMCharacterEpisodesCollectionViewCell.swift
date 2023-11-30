//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/20/23.
//

import UIKit

final class RMCharacterEpisodesCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - UI Elements
    
    private let seasonLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let airDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Override Methods
    
    override func prepareForReuse() {
        nameLabel.text = nil
        seasonLabel.text = nil
        airDataLabel.text = nil
    }
    
    //  MARK: - Configure Cell 
    
    func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel) {
        viewModel.registerForData { [weak self] data in
            self?.nameLabel.text = String(describing: data.name)
            self?.seasonLabel.text = "Episode: \(String(describing: data.episode))"
            self?.airDataLabel.text = "Aired on: \(String(describing: data.air_date))"
        }
        viewModel.fetchEpisodes()
    }
    
    private func setCell() {
        setAppearance()
        addSubViews()
        setConstains()
    }
    
}

extension RMCharacterEpisodesCollectionViewCell {
    
    //  MARK: - Private Methods
    
    private func setAppearance() {
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.systemGreen.cgColor
    }
    
    private func addSubViews() {
        addSubViews(seasonLabel, nameLabel, airDataLabel)
    }
    
    private func setConstains() {
        
        NSLayoutConstraint.activate([
        
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            seasonLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            airDataLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor),
            airDataLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            airDataLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            airDataLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)

        ])
        
    }
    
}
