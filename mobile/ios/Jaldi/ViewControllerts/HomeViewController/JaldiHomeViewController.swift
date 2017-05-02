//
//  JaldiHomeViewController.swift
//  Jaldi
//
//  Created by Grigori Jlavyan on 5/2/17.
//  Copyright © 2017 Handybook. All rights reserved.
//

import Foundation
import UIKit

class JaldiHomeViewController: UIViewController {
    
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var theCollectionView: UICollectionView!
    let  allCategories = HomeCategory.allCategories
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configuration()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.configuraZip()
    }
    
    //MARK: Configuration
    private func configuration() {
        self.configureCollectionView()
        
    }
    private func configuraZip() {
        guard let zip = UserProfile.currentProfile.guestZip else{
          zipCodeLabel.text = ""
            return
        }
        zipCodeLabel.text = "Not in: \(zip)?"
    }
    private func configureCollectionView() {
        let collectionViewLayout = theCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        let gab =  (self.view.frame.size.width - 2 * 130) / 3
        collectionViewLayout.sectionInset = UIEdgeInsetsMake(gab, gab, 0, gab)
        collectionViewLayout.minimumLineSpacing = 20
    }

    //MARK: Actions
    @IBAction func announcementAction(_ sender: Any) {
    }
    @IBAction func signInAction(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Login", bundle: nil)
        let signInViewController = storyboard.instantiateViewController(withIdentifier: "JaldiSignInViewController") as? JaldiSignInViewController
        self.present(signInViewController!, animated: true, completion: nil)

    }
    @IBAction func changeZipAction(_ sender: Any) {
    }
   
    
}

extension JaldiHomeViewController: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int{
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return allCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let cellIdentifier =  "JaldiHomeCollectionViewCell"
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? JaldiHomeCollectionViewCell {
            let category:HomeCategory = allCategories[indexPath.row]
            cell.configureWith(category: category)
            return cell
        } else {
            return UICollectionViewCell ()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let category:HomeCategory = allCategories[indexPath.row]
        self.navigateTo(category:category)

    }
    
    //MARK: navigate to Carpenter, Electrician, Mason, Painter, Plumber, Ac Technical
    fileprivate func navigateTo(category:HomeCategory) {
        switch category {
        case .carpenter:
            self.navigateToCarpenter()
        case .electrician:
            self.navigateToElectrician()
        case .mason:
            self.navigateToMason()
        case .painter:
            self.navigateToPainter()
        case .plumber:
            self.navigateToPlumber()
        case .acTechnical:
            self.navigateToAcTechnical()
        }
    }

    fileprivate func navigateToCarpenter() {
        print("Navigate to Carpenter")
    }
    
    fileprivate func navigateToElectrician() {
        print("Navigate to Electrician")
    }
    
    fileprivate func navigateToMason() {
        print("Navigate to Mason")
    }
    
    fileprivate func navigateToPainter() {
        print("Navigate to Painter")
    }
    
    fileprivate func navigateToPlumber() {
        print("Navigate to Plumber")
    }
    
    fileprivate func navigateToAcTechnical() {
        print("Navigate to Technical")
    }

}
