//
//  PhotoViewController.swift
//  SpacePhoto
//
//  Created by Souley on 23/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    // MARK: - User Interface Objects
    
    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let spacePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.contentMode = .scaleAspectFit
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.font = .preferredFont(forTextStyle: .body)
        label.font.withSize(10)
        label.numberOfLines = 0
        label.textAlignment = .justified
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let copyrightLabel: UILabel = {
        let label = UILabel()
        
        label.text = ""
        label.font = .preferredFont(forTextStyle: .footnote)
        label.font.withSize(10)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // MARK: - Properties
    
    let photoInfoController = PhotoInfoController()
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        photoInfoController.fetchPhotoInfo { (photoInfo) in
            if let photoInfo = photoInfo {
                self.updateUI(with: photoInfo)
            }
        }
        setupLayout()
    }
}

// MARK: - Extensions

extension PhotoViewController {
    
    func updateUI(with photoInfo: PhotoInfo) {
        guard let url = photoInfo.url.withHTTPS() else { return }
        
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.title = photoInfo.title
                    self.spacePhotoImageView.image = image
                    self.descriptionLabel.text = photoInfo.description
                    
                    if let copyright = photoInfo.copyright {
                        self.copyrightLabel.text = "Copyright: \(copyright)"
                    } else {
                        self.copyrightLabel.isHidden = true
                    }
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        })
        task.resume()
    }
    
    func setupLayout() {
        view.backgroundColor = .white
        
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        stackView.addSubview(spacePhotoImageView)
        stackView.addSubview(descriptionLabel)
        stackView.addSubview(copyrightLabel)
        
        scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        stackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10).isActive = true
        
        spacePhotoImageView.topAnchor.constraint(equalTo: stackView.topAnchor).isActive = true
        spacePhotoImageView.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        spacePhotoImageView.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        spacePhotoImageView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        descriptionLabel.topAnchor.constraint(equalTo: spacePhotoImageView.bottomAnchor, constant: 10).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: copyrightLabel.topAnchor, constant: -10).isActive = true
        
        copyrightLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10).isActive = true
        copyrightLabel.leadingAnchor.constraint(equalTo: stackView.leadingAnchor).isActive = true
        copyrightLabel.trailingAnchor.constraint(equalTo: stackView.trailingAnchor).isActive = true
        copyrightLabel.bottomAnchor.constraint(equalTo: stackView.bottomAnchor).isActive = true
    }

}
