//
//  RMCharacterCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/4/23.
//

import UIKit

/// Cell to Display Character Data in ChraterCollectionView
final class RMCharacterCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - Variables
    
    let traits = [UITraitUserInterfaceStyle.self]
    
    //  MARK: - UI Elements
    
    private let characterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let characterNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterStatusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let characterIndicatorStatusView: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        view.layer.cornerRadius =  60 / 2
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var characterStatusStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [characterIndicatorStatusView, characterStatusLabel])
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 5
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //  MARK: - Init Cell
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .secondarySystemBackground
        setLayer()
        setViewsAndConstrains()
        contentView.registerForTraitChanges(traits) { [weak self] (traitEnvironment: UITraitEnvironment, previousTraitCollection: UITraitCollection) in
            guard let self = self else { return }
            self.setLayer()
        }
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
        characterNameLabel.text = viewModel.getCharacterNameString
        characterStatusLabel.text = viewModel.getCharacterStatusString
        
        switch viewModel.getCharacterStatus {
        case .alive:
            characterIndicatorStatusView.backgroundColor = .green
        case .dead:
            characterIndicatorStatusView.backgroundColor = .red
        case .unknown:
            characterIndicatorStatusView.backgroundColor = .systemOrange
        }
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
    
    private func setLayer() {
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.cornerRadius = 4
        contentView.layer.shadowOffset = CGSize(width: -4, height: 4)
        contentView.layer.shadowOpacity = 0.3
    }
    
    private func setViewsAndConstrains() {
        contentView.addSubViews(characterImageView, characterNameLabel, characterStatusStack)
        
        NSLayoutConstraint.activate([
            
            characterStatusStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            characterStatusStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            characterStatusStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3),
            characterStatusStack.heightAnchor.constraint(equalToConstant: 40),
            
            characterIndicatorStatusView.topAnchor.constraint(equalTo: characterStatusStack.topAnchor),
            characterIndicatorStatusView.leadingAnchor.constraint(equalTo: characterStatusStack.leadingAnchor),
            characterIndicatorStatusView.bottomAnchor.constraint(equalTo: characterStatusStack.bottomAnchor),
            characterIndicatorStatusView.heightAnchor.constraint(equalToConstant: 15),
            characterIndicatorStatusView.widthAnchor.constraint(equalToConstant: 15),
            
            characterStatusLabel.topAnchor.constraint(equalTo: characterStatusStack.topAnchor),
            characterStatusLabel.leadingAnchor.constraint(equalTo: characterIndicatorStatusView.trailingAnchor, constant: 5),
            characterStatusLabel.trailingAnchor.constraint(equalTo: characterStatusStack.trailingAnchor),
            characterStatusLabel.bottomAnchor.constraint(equalTo: characterStatusStack.bottomAnchor),
            
            characterNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            characterNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            characterNameLabel.bottomAnchor.constraint(equalTo: characterStatusLabel.topAnchor),
            characterNameLabel.heightAnchor.constraint(equalToConstant: 40),
            
            characterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3),
            characterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: characterNameLabel.topAnchor, constant: -8)
            
        ])
        
    }
    
}
