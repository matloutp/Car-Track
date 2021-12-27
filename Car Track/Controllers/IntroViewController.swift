//
//  IntroViewController.swift
//  Car Track
//
//  Created by Thapelo on 2021/12/22.
//

import UIKit
import Hero

class IntroViewController: UIViewController {

    let logoImage: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "logoImage")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFit
        
        logo.alpha = 0
        
        return logo

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    func setup(){
        
        view.backgroundColor = .white//UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
        
        view.addSubview(logoImage)
        
        logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImage.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        logoImage.heightAnchor.constraint(equalToConstant: view.frame.width / 2.5).isActive = true
        logoImage.widthAnchor.constraint(equalToConstant: view.frame.width / 2.5).isActive = true
        
        animate()
        
    }
    
    func animate(){
        
        UIView.animate(withDuration: 3, animations: {
            
            self.logoImage.alpha = 1
            
        }) { (true) in
            
            self.perform(#selector(self.openHome), with: nil, afterDelay: 0.7)
            
        }
        
    }
    
    @objc func openHome(){
        
        if let userRegistered = UserDefaults.standard.object(forKey: "userRegistered") as? Bool {
            
            if userRegistered == true {
                
                let homeVC = HomeViewController()
                
                homeVC.modalPresentationStyle = .fullScreen
                
                present(homeVC, animated: true, completion: nil)
                
            }else {
                
                openLoginF()
                
            }
            
        }else {
            
            openLoginF()
            
        }
        
    }
    
    @objc func openLoginF(){
        
        let loginVC = LoginViewController()
        
        loginVC.modalPresentationStyle = .fullScreen
        
        
        loginVC.hero.isEnabled = true
        logoImage.hero.id = "logoImage"
        loginVC.topImage.hero.id = "logoImage"
        
        present(loginVC, animated: true, completion: nil)
        
    }

}
