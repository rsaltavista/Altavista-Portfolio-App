//
//  TileCollectionViewCell.swift
//  AltavistaPortfolio
//
//  Created by Ricardo Altavista on 27/06/24.
//

import UIKit

struct TileCollectionViewCellViewModel{
    let label: String
    let background: UIColor
    let icon: UIImage
    let backData: String?
    let backContent: String
    let backSkills: String?
}


class TileCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TileCollectionViewCell"
    
        private let frontView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
        
        private let backView: UIView = {
            let view = UIView()
            view.backgroundColor = .clear
            return view
        }()
    
        private let backData: UILabel = {
            let data = UILabel()
            data.font = .systemFont(ofSize: 22, weight: .medium)
            data.translatesAutoresizingMaskIntoConstraints = false
            return data
        }()
    
    private let backSkills: UILabel = {
        let backSkills = UILabel()
        backSkills.textAlignment = .justified
        backSkills.font = .systemFont(ofSize: 16, weight: .medium)
        backSkills.numberOfLines = 0
        backSkills.translatesAutoresizingMaskIntoConstraints = false
        return backSkills
    }()
    
        private let label: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            label.font = .systemFont(ofSize: 20, weight: .medium)
            return label
        }()
    
        private let iconView: UIImageView = {
            let iconView = UIImageView()
            return iconView
        }()
    
        private let backLabel: UILabel = {
           let label = UILabel()
            label.textAlignment = .natural
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.numberOfLines = 0
            label.translatesAutoresizingMaskIntoConstraints = false
           return label
        }()
    
    private func setupBackLabelConstraints(){
        NSLayoutConstraint.activate([
            backLabel.widthAnchor.constraint(equalToConstant: contentView.frame.width * 0.9),
            backLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -20)
        ])
    }
    private func setupBackSkillsConstraints(){
        NSLayoutConstraint.activate([
            backSkills.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 100),
            backSkills.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 5)
        ])
    }
    private func setupBackDataConstraints(){
        NSLayoutConstraint.activate([
            backData.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backData.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -150)
        ])
    }
       
       private var isFlipped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(frontView)
        contentView.addSubview(backView)
        contentView.addSubview(label)
        contentView.addSubview(iconView)
        backView.addSubview(backLabel)
        backView.addSubview(backData)
        backView.addSubview(backSkills)
        backView.isHidden = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        frontView.frame = contentView.bounds
        backView.frame = contentView.bounds
        label.frame = contentView.bounds
        iconView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        backLabel.frame = contentView.bounds
        backData.frame = contentView.bounds
        backSkills.frame = contentView.bounds
        setupBackLabelConstraints()
        setupBackDataConstraints()
        setupBackSkillsConstraints()
    }
    
    override func prepareForReuse() {
            super.prepareForReuse()
            resetCell()
        }
        
        private func resetCell() {
            isFlipped = false
            frontView.isHidden = false
            backView.isHidden = true
            label.isHidden = false
            iconView.isHidden = false
            backLabel.isHidden = true
            backData.isHidden = true
            backSkills.isHidden = true
        }
    
    
    func configure(with viewModel: TileCollectionViewCellViewModel, darkModeEnabled: Bool){
        contentView.backgroundColor = viewModel.background
        label.text = viewModel.label
        iconView.image = viewModel.icon
        label.textColor = darkModeEnabled ? .darkTile : .main
        iconView.tintColor = darkModeEnabled ? .darkTile : .main
        backLabel.text = viewModel.backContent
        backData.text = viewModel.backData
        backSkills.text = viewModel.backSkills
        backLabel.textColor = darkModeEnabled ? .darkTile : .main
        backData.textColor = darkModeEnabled ? .darkTile : .main
        backSkills.textColor = darkModeEnabled ? .darkTile : .main
    }
    
    func flip() {
            let fromView = isFlipped ? backView : frontView
            let toView = isFlipped ? frontView : backView
            
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: { [weak self] _ in
                guard let self = self else { return }
                           self.isFlipped.toggle()
                           self.frontView.isHidden = self.isFlipped
                           self.label.isHidden = self.isFlipped
                           self.iconView.isHidden = self.isFlipped
                           self.backLabel.isHidden = !self.isFlipped
                           self.backData.isHidden = !self.isFlipped
                           self.backSkills.isHidden = !self.isFlipped
            })
        }
}
