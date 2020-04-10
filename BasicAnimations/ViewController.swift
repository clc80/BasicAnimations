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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        label.center = view.center
    }
    
    func configureLabel() {
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


}

