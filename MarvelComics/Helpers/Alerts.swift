//
//  Alerts.swift
//  MarvelComics
//
//  Created by Gustavo Freitas on 28/03/22.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert() {
        let alert = UIAlertController(title: "Sorry 😕", message: "\nNo Hero found, try search for another one", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in
            self.dismiss(animated: true)
        }))
        
        present(alert, animated: true)
    }
}
