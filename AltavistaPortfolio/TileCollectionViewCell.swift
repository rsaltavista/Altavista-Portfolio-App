//
//  TileCollectionViewCell.swift
//  AltavistaPortfolio
//
//  Created by Ricardo Altavista on 27/06/24.
//

import UIKit

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
        
        private let linkedInLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemBlue
            label.isUserInteractionEnabled = true
            return label
        }()
        
        private let githubLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .left
            label.font = .systemFont(ofSize: 16, weight: .regular)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = .systemBlue
            label.isUserInteractionEnabled = true
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
    private func setupContactInfoConstraints() {
            NSLayoutConstraint.activate([
                linkedInLabel.topAnchor.constraint(equalTo: backLabel.bottomAnchor, constant: -56),
                linkedInLabel.leadingAnchor.constraint(equalTo: backLabel.leadingAnchor, constant: 70),
                linkedInLabel.trailingAnchor.constraint(equalTo: backLabel.trailingAnchor),
                
                githubLabel.topAnchor.constraint(equalTo: linkedInLabel.bottomAnchor, constant: 19),
                githubLabel.leadingAnchor.constraint(equalTo: backLabel.leadingAnchor, constant: 60),
                githubLabel.trailingAnchor.constraint(equalTo: backLabel.trailingAnchor)
            ])
        }
       
       private var isFlipped = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        frontView.frame = contentView.bounds
        backView.frame = contentView.bounds
        label.frame = contentView.bounds
        iconView.frame = CGRect(x: 20, y: 20, width: 40, height: 40)
        backLabel.frame = contentView.bounds
        backData.frame = contentView.bounds
        backSkills.frame = contentView.bounds
        contentView.addSubview(frontView)
        contentView.addSubview(backView)
        contentView.addSubview(label)
        contentView.addSubview(iconView)
        backView.addSubview(backLabel)
        backView.addSubview(backData)
        backView.addSubview(backSkills)
        backView.addSubview(linkedInLabel)
        backView.addSubview(githubLabel)
        let linkedInTapGesture = UITapGestureRecognizer(target: self, action: #selector(linkedInTapped))
        linkedInLabel.addGestureRecognizer(linkedInTapGesture)
                
        let githubTapGesture = UITapGestureRecognizer(target: self, action: #selector(githubTapped))
        githubLabel.addGestureRecognizer(githubTapGesture)
        backView.isHidden = true
        contentView.layer.cornerRadius = 10
        contentView.clipsToBounds = true

        setupBackLabelConstraints()
        setupBackDataConstraints()
        setupBackSkillsConstraints()
        setupContactInfoConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError()
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
    
    
    func configure(with viewModel: CardsViewModel, darkModeEnabled: Bool){
        contentView.backgroundColor = viewModel.background
        label.text = viewModel.label
        label.textColor = darkModeEnabled ? .darkTile : .main
        
        iconView.image = viewModel.icon
        iconView.tintColor = darkModeEnabled ? .darkTile : .main
        
        backLabel.text = viewModel.backContent
        backLabel.textColor = darkModeEnabled ? .darkTile : .main
        
        backData.text = viewModel.backData
        backData.textColor = darkModeEnabled ? .darkTile : .main
        
        backSkills.text = viewModel.backSkills
        backSkills.textColor = darkModeEnabled ? .darkTile : .main
        
        linkedInLabel.text = viewModel.linkedInURL
        githubLabel.text = viewModel.githubURL
        
        self.linkedInURL = viewModel.linkedInURL
        self.githubURL = viewModel.githubURL
    }
    
    func flip() {
        let fromView = isFlipped ? backView : frontView
        let toView = isFlipped ? frontView : backView
        
        UIView.transition(from: fromView, to: toView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews])
        
        isFlipped.toggle()
        frontView.isHidden = isFlipped
        label.isHidden = isFlipped
        iconView.isHidden = isFlipped
        backLabel.isHidden = !isFlipped
        backData.isHidden = !isFlipped
        backSkills.isHidden = !isFlipped
    }
    
        private var linkedInURL: String?
        private var githubURL: String?
        
        @objc private func linkedInTapped() {
            if let url = URL(string: linkedInURL ?? "") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        
        @objc private func githubTapped() {
            if let url = URL(string: githubURL ?? "") {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
}
