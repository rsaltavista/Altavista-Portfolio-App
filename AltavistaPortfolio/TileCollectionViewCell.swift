//
//  TileCollectionViewCell.swift
//  AltavistaPortfolio
//
//  Created by Ricardo Altavista on 27/06/24.
//

import UIKit

struct TileCollectionViewCellViewModel{
    let name: String
    let background: UIColor
}

class TileCollectionViewCell: UICollectionViewCell {
    static let identifier = "TileCollectionViewCell"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .main
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        contentView.layer.cornerRadius = 10
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = contentView.bounds
    }
    
    func configure(with viewModel: TileCollectionViewCellViewModel){
        contentView.backgroundColor = viewModel.background
        label.text = viewModel.name
    }
}
