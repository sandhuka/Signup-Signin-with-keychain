//
//  MenuViewController.swift
//  SignUp SIgnIn with Keychain
//
//  Created by Kanwar Sudeep Singh Sandhu on 08/05/18.
//  Copyright © 2018 Kanwar Sudeep Singh Sandhu. All rights reserved.
//

import UIKit
protocol SlideMenuDelegate {
    func slideMenuItemSelectedAtIndex(_ index: Int32)
}
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
  
    @IBOutlet weak var cellLabel: UILabel!
    
    var btnMenu : UIButton!
    var delegate : SlideMenuDelegate?
    var menuArray = ["Claims", "Terms", "Policy", "Profile"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var buttonMenuClose: UIButton!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func buttonMenuCloseTapped(_ sender: UIButton) {
        btnMenu.tag = 0
        btnMenu.isHidden = false
        if (self.delegate != nil){
            var index = Int32(sender.tag)
            if (sender == self.buttonMenuClose){
                index = -1
            }
            delegate?.slideMenuItemSelectedAtIndex(index)
        }
        UIView.animate(withDuration: 0.3, animations: {() -> Void in
            self.view.frame = CGRect(x: -UIScreen.main.bounds.size.width, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
            self.view.layoutIfNeeded()
            self.view.backgroundColor = UIColor.clear}, completion: {(finished) -> Void in
                self.view.removeFromSuperview()
                self.removeFromParentViewController()
        })
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuTableViewCell") as! MenuTableViewCell
        cell.cellLabel.text = menuArray[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedIndex = indexPath.row
       // print(selectedIndex)
        if (selectedIndex == 0){
            let mainstoreyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let claimsViewController = mainstoreyboard.instantiateViewController(withIdentifier: "ClaimsViewController") as! ClaimsViewController
            self.navigationController?.pushViewController(claimsViewController, animated: true)
            
        } else if (selectedIndex == 1){
            let mainstoreyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let claimsViewController = mainstoreyboard.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
            self.navigationController?.pushViewController(claimsViewController, animated: true)
            
        } else if (selectedIndex == 2){
            let mainstoreyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let claimsViewController = mainstoreyboard.instantiateViewController(withIdentifier: "PolicyViewController") as! PolicyViewController
            self.navigationController?.pushViewController(claimsViewController, animated: true)
            
        } else if (selectedIndex == 3 ){
            let mainstoreyboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let claimsViewController = mainstoreyboard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            self.navigationController?.pushViewController(claimsViewController, animated: true)
            
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
