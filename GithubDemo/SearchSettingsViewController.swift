//
//  SearchSettingsViewController.swift
//  GithubDemo
//
//  Created by Robert Mitchell on 3/1/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UIViewController {
    
    @IBOutlet var minStarLabel: UILabel!
    @IBOutlet var minStarSlider: UISlider!
    @IBOutlet var minStarCountLabel: UILabel!
    var settings: GithubRepoSearchSettings!
   
    weak var delegate: SettingsPresentingViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        settings.minStars = Int(minStarSlider.value)
        minStarLabel.text = "\(minStarSlider.value)"
        
        
        // Do any additional setup after loading the view.
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

    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let navController = segue.destination as! UINavigationController
        let vc = navController.topViewController as! RepoResultsViewController
        // vc.settings =
    }
    @IBAction func saveButtonTapped(_ sender: Any) {
        self.delegate?.didSaveSettings(settings: settings)
    }
    @IBAction func cancelButtonTapped(_ sender: Any) {
        self.delegate?.didCancelSettings()
    }

}

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}
