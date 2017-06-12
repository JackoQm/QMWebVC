//
//  ViewController.swift
//  TestDemo
//
//  Created by Jacko Qm on 16/04/2017.
//  Copyright © 2017 Jacko Qm. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!

    @IBAction func goSearch(_ sender: UIButton) {
        if let text = inputTextField.text {
            let wvc = QMWebViewController()
            wvc.requestUrl = text
            
            navigationController?.pushViewController(wvc, animated: true)
        }
    }
}

