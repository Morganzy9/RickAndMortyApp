//
//  RMCharacterInfoCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/20/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - UI Elements
    
    private let valuesLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 22, weight: .light)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "globe")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemBackground
        return view
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
        valuesLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        titleLabel.textColor = .label
        iconImageView.tintColor = .label
    }
    
    //  MARK: - Configure Cell
    
    func configure(with viewModel: RMCharacterInfoCollectionViewCellViewModel) {
        titleLabel.text = viewModel.title
        valuesLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.isconImage
        titleLabel.textColor = viewModel.tintColor
        iconImageView.tintColor = viewModel.tintColor
    }
    
    func setCell() {
        setContentCell()
        addSubViews()
        setConstains()
    }

}

extension RMCharacterInfoCollectionViewCell {
    
    //  MARK: - Private Methods
    
    private func setContentCell() {
        contentView.backgroundColor = .tertiarySystemGroupedBackground
        contentView.layer.cornerRadius = 9
        contentView.layer.masksToBounds = true
    }
    
    private func addSubViews() {
        contentView.addSubViews(titleContainerView, valuesLabel, iconImageView)
        titleContainerView.addSubview(titleLabel)
    }
    
    private func setConstains() {
        
        NSLayoutConstraint.activate([
            titleContainerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleContainerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleContainerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3),
            
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: titleContainerView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: titleContainerView.trailingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 35),
            iconImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            iconImageView.heightAnchor.constraint(equalToConstant: 30),
            iconImageView.widthAnchor.constraint(equalToConstant: 30),
            
            
            valuesLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valuesLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10),
            valuesLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            valuesLabel.bottomAnchor.constraint(equalTo: titleContainerView.topAnchor)
            
        ])
        
    }
    
}
