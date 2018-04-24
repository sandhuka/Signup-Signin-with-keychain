//
//  AppLaunchViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit

class AppLaunchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.navigationController?.navigationBar.isHidden = true
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
//
//            let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
//            self.present(loginVC, animated: true)
//        })
//
        
        
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
//            self.performSegue(withIdentifier: "goToLoginVC", sender: self)
//        })
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            
            let userID = UserDefaults.standard.value(forKey: "userid")
            
            if(userID != nil){ // Already logged in
                
                let homeScreenViewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                self.navigationController?.pushViewController(homeScreenViewController, animated: true)
            }
            else{
                
                let loginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
                self.navigationController?.pushViewController(loginVC, animated: true)
            }
            

        })
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
