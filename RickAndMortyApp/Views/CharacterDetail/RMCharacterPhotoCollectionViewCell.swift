//
//  RMCharacterPhotoCollectionViewCell .swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/20/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - UI ELements
    
    private let characterPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        characterPhotoImageView.image = nil
    }
    
    //  MARK: - Configure Cell
    
    func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        viewModel.fetchImage { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.characterPhotoImageView.image = UIImage(data: data)
                }
            case .failure:
                DispatchQueue.main.async {
                    self.characterPhotoImageView.image = UIImage(systemName: "photo.on.rectangle.angled")
                }
            }
        }
    }
    
    private func setCell() {
        addSubViews()
        setConstains()
    }
    
}

extension RMCharacterPhotoCollectionViewCell {
    
    //  MARK: - Private Methods
    
    private func addSubViews() {
        contentView.addSubview(characterPhotoImageView)
    }
    
    private func setConstains() {
        
        NSLayoutConstraint.activate([
        
            characterPhotoImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            characterPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            characterPhotoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            characterPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ])
        
    }
    
}

