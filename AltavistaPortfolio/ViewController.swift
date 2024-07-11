//
//  ViewController.swift
//  AltavistaPortfolio
//
//  Created by Ricardo Altavista on 24/06/24.
//

import UIKit

class ViewController: UIViewController{
    
    //MARK: Defining Variables
    
    private var currentLanguage: Translate = Translate.PTBR
    
    private lazy var darkModeClicked: Bool = {
        return traitCollection.userInterfaceStyle == .dark ? true :  false
    }()
    
    private var gradientLayer: CAGradientLayer?
    private var selectedItem: Language?
    
    private lazy var pickerViewPresenter: PickerViewPresenter = {
        let pickerViewPresenter = PickerViewPresenter()
        pickerViewPresenter.didSelectItem = { [weak self] item in
            self?.selectedItem = item
            self?.languageLabel.attributedText = self?.getLabelWithIcon(for: item.name)
            self?.updateLanguage(to: item.name)

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
    
    private var viewModels: [CollectionTableViewCellViewModel] = [
        CollectionTableViewCellViewModel(viewModels: [
            TileCollectionViewCellViewModel(label: Translate.PTBR.experiencia, background: .white, icon: UIImage(systemName: "briefcase.circle")!, backData: "09/22 - 12/23", backContent: Translate.PTBR.experieciaDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: Translate.PTBR.sobreMim, background: .white, icon: UIImage(systemName: "person.circle")!, backData: "", backContent: Translate.PTBR.sobreMimDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: Translate.PTBR.cursos, background: .white, icon: UIImage(systemName: "book.circle")!, backData: "", backContent: Translate.PTBR.cursosDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: Translate.PTBR.formacao, background: .white, icon: UIImage(systemName: "graduationcap.circle")!, backData: "03/22 - 12/23", backContent: Translate.PTBR.formacaoDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: Translate.PTBR.skills, background: .white, icon: UIImage(systemName: "circle.hexagongrid.circle")!, backData: "", backContent: "", backSkills: Translate.PTBR.skillsDescricao),
            TileCollectionViewCellViewModel(label: Translate.PTBR.freelancer, background: .white, icon: UIImage(systemName: "pencil.tip.crop.circle")!, backData: "", backContent: Translate.PTBR.freelancerDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: Translate.PTBR.contato, background: .white, icon: UIImage(systemName: "envelope.circle")!, backData: "", backContent: Translate.PTBR.contatoDescricao, backSkills: ""),
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
        darkModeImage.translatesAutoresizingMaskIntoConstraints = false
        return darkModeImage
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // MARK: Variable to make the title color white
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.standardAppearance = appearance
        
        //MARK: properties of languageLabel
        setupLanguageLabel()
        
        pickerViewPresenter.items = languages.map { Language(name: $0) }
        
        let darkModeTapGesture = UITapGestureRecognizer(target: self, action: #selector(darkModeTapped))
        darkModeImage.addGestureRecognizer(darkModeTapGesture)

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
    
    //MARK: Function to add a gradient background color
    
    private func createGradientLayer() {
            gradientLayer = CAGradientLayer()
            gradientLayer?.frame = view.bounds
        updateGradientColors()

            if let gradientLayer = gradientLayer {
                view.layer.insertSublayer(gradientLayer, at: 0)
            }
        }
    
    private func updateGradientColors() {
            if traitCollection.userInterfaceStyle == .dark {
                gradientLayer?.colors = [
                    UIColor.black.cgColor,
                    UIColor.blue.cgColor,
                    UIColor.purple.cgColor,
                ]
                darkModeImage.image = UIImage(systemName: "sun.min.fill")
            } else {
                gradientLayer?.colors = [
                    UIColor.firstGradient.cgColor,
                    UIColor.secondGradient.cgColor,
                    UIColor.thirdGradient.cgColor,
                ]
            }
        }
    
    private func updateBackgroundIfTapped(darkMode: Bool){
        if darkMode{
            darkModeImage.image = UIImage(systemName: "sun.min.fill")
            gradientLayer?.colors = [
                UIColor.black.cgColor,
                UIColor.blue.cgColor,
                UIColor.purple.cgColor,
            ]
        }
        else{
            darkModeImage.image = UIImage(systemName: "moon.fill")
            gradientLayer?.colors = [
                UIColor.firstGradient.cgColor,
                UIColor.secondGradient.cgColor,
                UIColor.thirdGradient.cgColor,
            ]
        }
    }
    
    private func updateLanguage(to language: String){
        switch language{
        case "PT-BR":
            currentLanguage = Translate.PTBR
        case "EN-US":
            currentLanguage = Translate.ENUS
        default:
            currentLanguage = Translate.PTBR
        }
        updateUIForCurrentLanguage()
    }
    
    private func updateUIForCurrentLanguage() {
        
        // Update the collection view cell view models
        let newViewModels = [
            TileCollectionViewCellViewModel(label: currentLanguage.experiencia, background: .white, icon: UIImage(systemName: "briefcase.circle")!, backData: "09/22 - 12/23", backContent: currentLanguage.experieciaDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: currentLanguage.sobreMim, background: .white, icon: UIImage(systemName: "person.circle")!, backData: "", backContent: currentLanguage.sobreMimDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: currentLanguage.cursos, background: .white, icon: UIImage(systemName: "book.circle")!, backData: "", backContent: currentLanguage.cursosDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: currentLanguage.formacao, background: .white, icon: UIImage(systemName: "graduationcap.circle")!, backData: "03/22 - 12/23", backContent: currentLanguage.formacaoDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: currentLanguage.skills, background: .white, icon: UIImage(systemName: "circle.hexagongrid.circle")!, backData: "", backContent: "", backSkills: currentLanguage.skillsDescricao),
            TileCollectionViewCellViewModel(label: currentLanguage.freelancer, background: .white, icon: UIImage(systemName: "pencil.tip.crop.circle")!, backData: "", backContent: currentLanguage.freelancerDescricao, backSkills: ""),
            TileCollectionViewCellViewModel(label: currentLanguage.contato, background: .white, icon: UIImage(systemName: "envelope.circle")!, backData: "", backContent: currentLanguage.contatoDescricao, backSkills: "")
        ]
        
        viewModels[0] = CollectionTableViewCellViewModel(viewModels: newViewModels)
        tableView.reloadData()
    }
    
    private func setupLanguageLabel(){
        languageLabel = UILabel()
        languageLabel.attributedText = getLabelWithIcon(for: languages[0])
        languageLabel.textColor = .white
        languageLabel.numberOfLines = 1
        languageLabel.lineBreakMode = .byTruncatingTail
        languageLabel.adjustsFontSizeToFitWidth = true
        languageLabel.minimumScaleFactor = 0.5
        languageLabel.isUserInteractionEnabled = true
        let languageLabelTapGesture = UITapGestureRecognizer(target: self, action: #selector(languageLabelTapped))
        languageLabel.addGestureRecognizer(languageLabelTapGesture)
    }
    
    //MARK: creating navigationBar
    private func setupNavigationBar(){
        self.title = "Altavista Portfolio App"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: languageLabel)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: darkModeImage)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if gradientLayer == nil {
                    createGradientLayer()
                } else {
                    gradientLayer?.frame = view.bounds
                }
        tableView.frame = CGRect(x: 0, y: 370, width: view.bounds.width, height: 400)
        profileImageView.layer.cornerRadius = profileImageView.frame.size.width / 2

    }
    
//MARK: setting constraints
    
    //MARK: Constraints of profile image
    private func setProfileImageConstraints(){
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(greaterThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            profileImageView.widthAnchor.constraint(equalToConstant: 120),
            profileImageView.heightAnchor.constraint(equalToConstant: 120),
        ])
    }

    // MARK: Constraints of darkmodeIcon
    private func setDarkModeImageConstraints(){
        NSLayoutConstraint.activate([
            darkModeImage.widthAnchor.constraint(equalToConstant: 30),
            darkModeImage.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    // MARK: Constraints of Name
    private func setNameConstraints(){
        NSLayoutConstraint.activate([
            name.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            name.centerYAnchor.constraint(greaterThanOrEqualTo: profileImageView.centerYAnchor, constant: 100)
        ])
    }
    //MARK: Function called when user click on language label
    @objc private func languageLabelTapped() {
        pickerViewPresenter.showPicker()
    }
    //MARK: Function called when user click on darkmode icon
    @objc private func darkModeTapped(){
        darkModeClicked.toggle()
        updateBackgroundIfTapped(darkMode: darkModeClicked)
        tableView.reloadData()
    }

    //MARK: Function to put a icon on language label
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
        cell.configure(with: viewModel, darkModeEnabled: darkModeClicked)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
        
}
