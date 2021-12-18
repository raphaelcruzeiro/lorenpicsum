//
//  ViewController.swift
//  Loren Picsum
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit
import Networking

class ViewController: UIViewController {
    
    let imageService = ImageService()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            do {
                let images = try await imageService.fetch()
                print(images)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}

