//
//  File.swift
//  
//
//  Created by Raphael Cruzeiro on 18/12/2021.
//

import UIKit
import Networking

public class ImageListViewController: UIViewController {
    
    let imageService = ImageService()

    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        Task {
            do {
                let images = try await imageService.list()
                print(images)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
