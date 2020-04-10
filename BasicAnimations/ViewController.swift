//
//  ViewController.swift
//  BasicAnimations
//
//  Created by Claudia Contreras on 4/9/20.
//  Copyright © 2020 thecoderpilot. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var label: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLabel()
        configureButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.center = view.center
    }
    
    private func configureLabel() {
        label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        label.widthAnchor.constraint(equalTo: label.heightAnchor).isActive = true
        
        label.text = "👩🏻‍✈️"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 96)
        
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 12
    }

    private func configureButtons() {
        let rotateButton = UIButton(type: .system)
        rotateButton.translatesAutoresizingMaskIntoConstraints = false
        rotateButton.setTitle("Rotate", for: .normal)
        rotateButton.addTarget(self, action: #selector(rotateButtonTapped), for: .touchUpInside)
        
        let springButton = UIButton(type: .system)
        springButton.translatesAutoresizingMaskIntoConstraints = false
        springButton.setTitle("Spring", for: .normal)
        springButton.addTarget(self, action: #selector(springButtonTapped), for: .touchUpInside)
        
        let keyButton = UIButton(type: .system)
        keyButton.translatesAutoresizingMaskIntoConstraints = false
        keyButton.setTitle("Key", for: .normal)
        keyButton.addTarget(self, action: #selector(keyButtonTapped), for: .touchUpInside)
        
        let squashButton = UIButton(type: .system)
        squashButton.translatesAutoresizingMaskIntoConstraints = false
        squashButton.setTitle("Squash", for: .normal)
        squashButton.addTarget(self, action: #selector(squashButtonTapped), for: .touchUpInside)
        
        let anticipationButton = UIButton(type: .system)
        anticipationButton.translatesAutoresizingMaskIntoConstraints = false
        anticipationButton.setTitle("Anticipation", for: .normal)
        anticipationButton.addTarget(self, action: #selector(anticipationButtonTapped), for: .touchUpInside)

        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        // Stackview parameters
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        // Add the buttons inside the stackview
        stackView.addArrangedSubview(rotateButton)
        stackView.addArrangedSubview(springButton)
        stackView.addArrangedSubview(keyButton)
        stackView.addArrangedSubview(squashButton)
        stackView.addArrangedSubview(anticipationButton)
        
        // Constrain the stackview
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }

    @objc private func rotateButtonTapped() {
        //Reset to the center
        label.center = view.center
        
        UIView.animate(withDuration: 2.0, animations: {
            self.label.transform = CGAffineTransform(rotationAngle: .pi/4)
        }) { _ in
            UIView.animate(withDuration: 2.0) {
                //.identity means you go back to it's original state
                self.label.transform = .identity
            }
        }
        
    }
    
    @objc private func springButtonTapped() {
        label.center = view.center
        
        label.transform = CGAffineTransform(scaleX: 0.0001, y: 0.0001)
        UIView.animate(withDuration: 3.0, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: [], animations: {
            self.label.transform = .identity
        }, completion: nil)
    }
    
    @objc private func keyButtonTapped() {
        label.center = view.center
        
        UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [], animations: {
            //Relative Start time and duration are based on percentages of the animation time so from 0% to 25% it will rotate
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.25) {
                self.label.transform = CGAffineTransform(rotationAngle: .pi/4)
            }
            //this one will run from 25% for another 1/4 of the time so it will end at 50% of the time
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {
                self.label.transform = .identity
            }
            UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25) {
                self.label.transform = CGAffineTransform(translationX: 0, y: -50)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {
                self.label.transform = .identity
            }
        }, completion: nil)
    }
    @objc private func squashButtonTapped() {
        //Move the label up (to make sure it's up all the way past the top of the screen we do minus(-) the size of the label) but still in the middle
        label.center = CGPoint(x: view.center.x, y: -label.bounds.size.height)
        
        let  animationBlock = {
            // fall down to the middle of the screen
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.4) {
                self.label.center = self.view.center
            }
            // We have some overlap, scale in both dimensions so it's wide (170%) and short (60% shorter)
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 1.7, y: 0.6)
            }
            // Skinny and tall
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.2) {
                self.label.transform = CGAffineTransform(scaleX: 0.6, y: 1.7)
            }
            //smaller short and wide motion
            UIView.addKeyframe(withRelativeStartTime: 0.7, relativeDuration: 0.15) {
                self.label.transform = CGAffineTransform(scaleX: 1.11, y: 0.9)
            }
            //Back to normal
            UIView.addKeyframe(withRelativeStartTime: 0.85, relativeDuration: 0.15) {
                self.label.transform = .identity
            }
        }
        
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animationBlock, completion: nil)
    }
    
    @objc func anticipationButtonTapped() {
        label.center = view.center
        
        let animationBlock = {
            //show that it's going to start moving
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.10) {
                self.label.transform = CGAffineTransform(rotationAngle: .pi/16)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.10, relativeDuration: 0.20) {
                self.label.transform = CGAffineTransform(rotationAngle: -1 * .pi/16)
            }
            UIView.addKeyframe(withRelativeStartTime: 0.2, relativeDuration: 0.80) {
                self.label.center = CGPoint(
                    x: self.view.bounds.size.width + self.label.bounds.size.width,
                    y: self.view.center.y
                )
            }
        }
            
        UIView.animateKeyframes(withDuration: 1.5, delay: 0, options: [], animations: animationBlock, completion: nil)
    }
}

