//
//  RMCharacterPhotoCollectionViewCell .swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/20/23.
//

import UIKit

final class RMCharacterPhotoCollectionViewCell: UICollectionViewCell {
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Override Methods
    
    override func prepareForReuse() {
        
    }
    
    //  MARK: - Configure Cell
    
    func configure(with viewModel: RMCharacterPhotoCollectionViewCellViewModel) {
        
    }
    
}

extension RMCharacterInfoCollectionViewCell {
    
    //  MARK: - Private Methods
    
    private func setConstains() {
        
    }
    
}

