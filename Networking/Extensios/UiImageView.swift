//
//  UiImageView.swift
//  Networking
//
//  Created by karim  on 10/08/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func setImageFromStringrlL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
            self.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
    
    func makeImagrCircle() {
        
        self.layer.cornerRadius = self.frame.height/2
    }
}
