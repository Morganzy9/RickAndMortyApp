//
//  RMCharacterEpisodesCollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/20/23.
//

import UIKit

final class RMCharacterEpisodesCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - Varibales and Constants
    
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
        
    }
    
    //  MARK: - Configure Cell 
    
    func configure(with viewModel: RMCharacterEpisodesCollectionViewCellViewModel) {
        viewModel.registerForData { data in
            print(String(describing: data))
        }
        viewModel.fetchEpisodes()
    }
    
    private func setCell() {
        setAppearance()
    }
    
}

extension RMCharacterEpisodesCollectionViewCell {
    
    //  MARK: - Private Methods
    
    private func setAppearance() {
        contentView.backgroundColor = .red
        contentView.layer.cornerRadius = 8
    }
    
    private func setConstains() {
        
    }
    
}
