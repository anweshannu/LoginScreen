//
//  HomeScreenViewController.swift
//  Challenge1
//
//  Created by Anwesh M on 31/01/22.
//

import UIKit
import SideMenu

class TableViewCell: UITableViewCell{
    
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    
}


class HomeScreenViewController: UIViewController{
    
    @IBOutlet weak var sideMenuIconImageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    var sideMenuNC: SideMenuNavigationController!
    var sideMenuVC: SideMenuViewController!
    var user: User!
    
    override func viewDidLoad() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(sideMenuImageViewTapped))
        self.sideMenuIconImageView.isUserInteractionEnabled = true
        self.sideMenuIconImageView.addGestureRecognizer(tapRecognizer)
        
        tableView.delegate = self
        tableView.dataSource = self
        configureSideMenu()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    override func viewDidLayoutSubviews() {
        let width = view.bounds.width < view.bounds.height  ? view.bounds.width : view.bounds.height
        sideMenuNC.menuWidth = width * 0.7
    }
    
    @objc func sideMenuImageViewTapped(){
        self.present(sideMenuNC, animated: true, completion: nil)
    }
    
    ///  configures sidemenu
    private func configureSideMenu(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sideMenuVC = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as? SideMenuViewController
        sideMenuVC.view.backgroundColor = .systemRed
        sideMenuNC = .init(rootViewController: sideMenuVC)
        sideMenuNC.leftSide = true
        sideMenuNC.isNavigationBarHidden = false
        sideMenuNC.statusBarEndAlpha = 0
        sideMenuVC.homeDelegate = self
    }
    
    /// action when view in maps label tapped
    @objc func onViewInMapsButtonTapped(_ sender: Any) {
        guard let url = URL(string: "http://maps.apple.com/maps?saddr=&daddr=\(user.location!.latitude),\(user.location!.longitude)") else{return}
        UIApplication.shared.open(url)
    }
}

extension HomeScreenViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.location == nil ? 5 : 6
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as! TableViewCell
        
        switch indexPath.row{
        case 0:
            cell.keyLabel.text = "Name: "
            cell.valueLabel.text = user.name
        case 1:
            cell.keyLabel.text = "Email Id: "
            cell.valueLabel.text = user.email
        case 2:
            cell.keyLabel.text = "Phone No.: "
            cell.valueLabel.text = user.phoneNumber
        case 3:
            cell.keyLabel.text = "Address: "
            cell.valueLabel.text = user.address
        case 4:
            cell.keyLabel.text = "Gender: "
            cell.valueLabel.text = user.gender.rawValue
        case 5:
            cell.keyLabel.text = "Location: "
            cell.valueLabel.text = "View in Maps"
            cell.valueLabel.textColor = .blue
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onViewInMapsButtonTapped))
            cell.valueLabel.addGestureRecognizer(tapGesture)
            cell.valueLabel.isUserInteractionEnabled = true
        default:
            break
        }
        return cell
    }
    
}

