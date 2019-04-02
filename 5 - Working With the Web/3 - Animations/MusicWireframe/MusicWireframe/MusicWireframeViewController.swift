//
//  MusicWireframeViewController.swift
//  MusicWireframe
//
//  Created by Souley on 16/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation
import UIKit

class MusicWireframeViewController : UIViewController {
    
    // MARK: - UI Subviews
    
    let albumImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.backgroundColor = .purple
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    let buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    let reverseButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "reverse"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let playPauseButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "pause"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let forwardButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "forward"), for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let reverseBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 35.0
        view.clipsToBounds = true
        view.alpha = 0.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let playPauseBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 35.0
        view.clipsToBounds = true
        view.alpha = 0.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    let forwardBackground: UIView = {
        let view = UIView()
        
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 35.0
        view.clipsToBounds = true
        view.alpha = 0.0
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    // MARK: - Properties
    
    var isPlaying: Bool = true {
        didSet {
            if isPlaying {
                playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            } else {
                playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            }
        }
    }
    
    // MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupLayout()
        setupActions()
    }
 
    // MARK: - Actions
    
    @objc func playPauseButtonTapped() {
        if isPlaying {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            }
        } else {
            UIView.animate(withDuration: 0.5) {
                self.albumImageView.transform = CGAffineTransform.identity
            }
        }
        isPlaying = !isPlaying
    }
    
    @objc func touchedDown(sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25) {
            buttonBackground.alpha = 0.3
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @objc func touchUpInside(sender: UIButton) {
        let buttonBackground: UIView
        
        switch sender {
        case reverseButton:
            buttonBackground = reverseBackground
        case playPauseButton:
            buttonBackground = playPauseBackground
        case forwardButton:
            buttonBackground = forwardBackground
        default:
            return
        }
        
        UIView.animate(withDuration: 0.25, animations: {
            buttonBackground.alpha = 0.0
            buttonBackground.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
            sender.transform = CGAffineTransform.identity
        }) { (_) in
            buttonBackground.transform = CGAffineTransform.identity
        }
    }
    
    // MARK: - Setup functions
    
    func setupActions() {
        reverseButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        reverseButton.addTarget(self, action: #selector(touchedDown), for: .touchDown)
        
        playPauseButton.addTarget(self, action: #selector(playPauseButtonTapped), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        playPauseButton.addTarget(self, action: #selector(touchedDown), for: .touchDown)
        
        forwardButton.addTarget(self, action: #selector(touchUpInside), for: .touchUpInside)
        forwardButton.addTarget(self, action: #selector(touchedDown), for: .touchDown)
    }
    
    func setupLayout() {
        let safeArea = view.safeAreaLayoutGuide
        
        view.addSubview(albumImageView)
        view.addSubview(buttonsStackView)
        view.addSubview(reverseBackground)
        view.addSubview(playPauseBackground)
        view.addSubview(forwardBackground)
        
        buttonsStackView.addSubview(reverseButton)
        buttonsStackView.addSubview(playPauseButton)
        buttonsStackView.addSubview(forwardButton)
        
        albumImageView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        albumImageView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 10).isActive = true
        albumImageView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -10).isActive = true
        albumImageView.bottomAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        albumImageView.heightAnchor.constraint(equalTo: albumImageView.widthAnchor, multiplier: 1.0/1.0).isActive = true
        
        buttonsStackView.topAnchor.constraint(equalTo: albumImageView.bottomAnchor, constant: 20).isActive = true
        buttonsStackView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20).isActive = true
        buttonsStackView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20).isActive = true
        buttonsStackView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor).isActive = true
        
        reverseButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor).isActive = true
        reverseButton.leadingAnchor.constraint(equalTo: buttonsStackView.leadingAnchor).isActive = true
        
        playPauseButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor).isActive = true
        playPauseButton.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor).isActive = true
        
        forwardButton.topAnchor.constraint(equalTo: buttonsStackView.topAnchor).isActive = true
        forwardButton.trailingAnchor.constraint(equalTo: buttonsStackView.trailingAnchor).isActive = true
        
        reverseBackground.widthAnchor.constraint(equalToConstant: 70).isActive = true
        reverseBackground.heightAnchor.constraint(equalToConstant: 70).isActive = true
        reverseBackground.centerXAnchor.constraint(equalTo: reverseButton.centerXAnchor).isActive = true
        reverseBackground.centerYAnchor.constraint(equalTo: reverseButton.centerYAnchor).isActive = true

        playPauseBackground.widthAnchor.constraint(equalToConstant: 70).isActive = true
        playPauseBackground.heightAnchor.constraint(equalToConstant: 70).isActive = true
        playPauseBackground.centerXAnchor.constraint(equalTo: playPauseButton.centerXAnchor).isActive = true
        playPauseBackground.centerYAnchor.constraint(equalTo: playPauseButton.centerYAnchor).isActive = true
        
        forwardBackground.widthAnchor.constraint(equalToConstant: 70).isActive = true
        forwardBackground.heightAnchor.constraint(equalToConstant: 70).isActive = true
        forwardBackground.centerXAnchor.constraint(equalTo: forwardButton.centerXAnchor).isActive = true
        forwardBackground.centerYAnchor.constraint(equalTo: forwardButton.centerYAnchor).isActive = true

        view.sendSubviewToBack(reverseBackground)
        view.sendSubviewToBack(playPauseBackground)
        view.sendSubviewToBack(forwardBackground)
    }
    
}
