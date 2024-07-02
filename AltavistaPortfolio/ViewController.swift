//
//  ViewController.swift
//  AltavistaPortfolio
//
//  Created by Ricardo Altavista on 24/06/24.
//

import UIKit

class ViewController: UIViewController{
    
    //MARK: Defining Variables
    
    private var selectedItem: Language?
    
    private lazy var pickerViewPresenter: PickerViewPresenter = {
        let pickerViewPresenter = PickerViewPresenter()
        pickerViewPresenter.didSelectItem = { [weak self] item in
            self?.selectedItem = item
            self?.languageLabel.attributedText = self?.getLabelWithIcon(for: item.name)
        }
        return pickerViewPresenter
    }()

    private let name: UILabel = {
        let name = UILabel()
        name.text = "Ricardo dos Santos Altavista"
        name.textColor = .white
        name.textAlignment = .center
        name.font = UIFont(name: "Knewave-Regular", size: 24)
        name.translatesAutoresizingMaskIntoConstraints = false
        return name
    }()
    
    private let viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(viewModels: [
            TileCollectionViewCellViewModel(name: "Apple", background: .white),
            TileCollectionViewCellViewModel(name: "Microsoft", background: .white),
            TileCollectionViewCellViewModel(name: "Samsung", background: .white),
            TileCollectionViewCellViewModel(name: "Nvidia", background: .white),
            TileCollectionViewCellViewModel(name: "Xiaomi", background: .white),
            TileCollectionViewCellViewModel(name: "Tesla", background: .white),
            TileCollectionViewCellViewModel(name: "Instagram", background: .white),
            TileCollectionViewCellViewModel(name: "Facebook", background: .white),
            TileCollectionViewCellViewModel(name: "Snapchat", background: .white),
            TileCollectionViewCellViewModel(name: "TikTok", background: .white),
        ])
    ]
    private let languages: [String] = ["PT-BR", "EN-US"]
    private var languageLabel: UILabel!
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    private let profileImageView: UIImageView = {
        let profileImageView = UIImageView()
        let imageName = "FaceRicardo.jpg"
        let image = UIImage(named: imageName)
        profileImageView.image = image
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        return profileImageView
    }()
    
    private let darkModeImage: UIImageView = {
        let darkModeImage = UIImageView()
        let image = UIImage(systemName: "moon.fill")
        darkModeImage.image = image
        darkModeImage.tintColor = .white
        darkModeImage.layer.shadowColor = UIColor.black.cgColor
        darkModeImage.layer.shadowOpacity = 0.5
        darkModeImage.layer.shadowRadius = 3.0
        darkModeImage.layer.shadowOffset.width = 1
        darkModeImage.layer.shadowOffset.height = 4
        darkModeImage.translatesAutoresizingMaskIntoConstraints = false
        return darkModeImage
    }()
    
    //MARK: Function to add a gradient background color
    
    private func addHeaderGradient() {
        let gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = [
            UIColor.firstGradient.cgColor,
            UIColor.secondGradient.cgColor,
            UIColor.thirdGradient.cgColor,
        ]
        view.layer.addSublayer(gradient)
      }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addHeaderGradient()
                
        //MARK: properties of languageLabel
        languageLabel = UILabel()
        languageLabel.attributedText = getLabelWithIcon(for: languages[0])
        languageLabel.textColor = .white
        languageLabel.numberOfLines = 1
        languageLabel.lineBreakMode = .byTruncatingTail
        languageLabel.adjustsFontSizeToFitWidth = true
        languageLabel.minimumScaleFactor = 0.5
        languageLabel.isUserInteractionEnabled = true
        languageLabel.layer.shadowColor = UIColor.black.cgColor
        languageLabel.layer.shadowRadius = 3.0
        languageLabel.layer.shadowOpacity = 0.5
        languageLabel.layer.shadowOffset.width = 1
        languageLabel.layer.shadowOffset.height = 4
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(buttonTapped))
        languageLabel.addGestureRecognizer(tapGesture)
        
        pickerViewPresenter.items = languages.map { Language(name: $0) }

        //MARK: adding subViews
        self.view.addSubview(profileImageView)
        self.view.addSubview(darkModeImage)
        self.view.addSubview(tableView)
        self.view.addSubview(name)
        self.view.addSubview(pickerViewPresenter)
        
        //MARK: protocols methods of tableView
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        
        //MARK: calling constraints
        setProfileImageConstraints()
        setDarkModeImageConstraints()
        setNameConstraints()
        
        //MARK: calling navigationBar
        setupNavigationBar()
    }
    
    //MARK: creating navigationBar
    private func setupNavigationBar(){
        self.title = "Altavista Portfolio App"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: languageLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: darkModeImage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: 370, width: view.bounds.width, height: 400)

        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2

    }
    
    //MARK: setting constraints
    private func setProfileImageConstraints(){
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }

    private func setDarkModeImageConstraints(){
        NSLayoutConstraint.activate([
            darkModeImage.widthAnchor.constraint(equalToConstant: 30),
            darkModeImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    private func setNameConstraints(){
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.centerYAnchor.constraint(greaterThanOrEqualTo: profileImageView.centerYAnchor, constant: 100)
        ])
    }
    
    @objc private func buttonTapped() {
        pickerViewPresenter.showPicker()
    }
    
    private func getLabelWithIcon(for language: String) -> NSAttributedString{
        let fullString = NSMutableAttributedString(string: language)
        
        if let icon = UIImage(systemName: "chevron.down"){
            let iconColor = UIColor.white
            let coloredIcon = icon.withTintColor(iconColor, renderingMode: .alwaysOriginal)
            let imageAttachment = NSTextAttachment()
            imageAttachment.image = coloredIcon
            icon.withTintColor(.white)
            
            let imageOffSetY: CGFloat = -2.0
            imageAttachment.bounds = CGRect(x: 0, y: imageOffSetY, width: icon.size.width, height: icon.size.height)
            
            let imageString = NSAttributedString(attachment: imageAttachment)
            fullString.append(NSAttributedString(string: ""))
            fullString.append(imageString)
        }
        
        return fullString
    }
    
}

extension ViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = viewModels[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as? CollectionTableViewCell else{
            fatalError()
        }
        cell.configure(with: viewModel)
        cell.delegateCollection = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
        
}

extension ViewController: CollectionTableViewCellDelegate{
    func collectionTableViewCellDidTapItem(with viewModel: TileCollectionViewCellViewModel) {
        print("opened a new view")
    }
}






