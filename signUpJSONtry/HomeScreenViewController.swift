//
//  HomeScreenViewController.swift
//  signUpJSONtry
//
//  Created by Kanwar Sudeep Singh Sandhu on 20/04/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit

class HomeScreenViewController: BaseViewController {

    @IBOutlet weak var nameDisplayLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        setupNavigationBar()
        addSlideMenuButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupNavigationBar(){
    
        //Set navigation title
        self.navigationItem.title = "Home Screen"
        
        // Hide back button
        self.navigationItem.hidesBackButton = true
        
        //Add right bar button
        
        let btnLogout = UIButton.init(frame: CGRect(x: 0, y:0, width: 40, height: 40))
        
        btnLogout.setTitle("Logout", for: .normal)
        btnLogout.setTitleColor(.red, for: .normal)
        
        
        btnLogout.addTarget(self, action: #selector(logoutButtonPressed), for: .touchUpInside)
        
        let brBtnLogout  = UIBarButtonItem.init(customView: btnLogout)
        
        self.navigationItem.rightBarButtonItem = brBtnLogout
    
    }
    
    //MARK:- Logout button
    @objc func logoutButtonPressed(_ sender: Any) {
        
        UserDefaults.standard.set(nil, forKey: "userid")
        
        
        //Move to splash screen
        moveToSplashScreen()
        
    }
    

    //MARK:- Move to splash screen
    func moveToSplashScreen() {
     
        for controller in self.navigationController!.viewControllers as Array {
            if controller.isKind(of: AppLaunchViewController.self) {
                self.navigationController!.popToViewController(controller, animated: true)
                break
            }
        }
        
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
