//
//  SettingsTableViewController.swift
//  GithubDemo
//
//  Created by Calvin Chu on 2/16/17.
//  Copyright © 2017 codepath. All rights reserved.
//

import UIKit

class SearchSettingsViewController: UITableViewController {

    @IBOutlet weak var minStarValue: UILabel!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var langSwitch: UISwitch!
    @IBOutlet weak var javaCell: UITableViewCell!
    @IBOutlet weak var javascriptCell: UITableViewCell!
    @IBOutlet weak var objectivecCell: UITableViewCell!
    @IBOutlet weak var pythonCell: UITableViewCell!
    @IBOutlet weak var rubyCell: UITableViewCell!
    @IBOutlet weak var swiftCell: UITableViewCell!
    
    var settings: GithubRepoSearchSettings?

    weak var delegate: SettingsPresentingViewControllerDelegate?
    
    var languages = ["Java", "JavaScript", "Objective-C", "Python", "Ruby", "Swift"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let numberOfRows = tableView.numberOfRows(inSection: 1)
        for row in 1...(numberOfRows-1) {
            let cell = tableView.cellForRow(at: IndexPath(row: row, section: 1))
            cell?.textLabel?.text = languages[row-1]
        }
        
        slider.value = Float(settings!.minStars)
        slider.sendActions(for: UIControlEvents.valueChanged)
        langSwitch.setOn((settings?.langSwitch)!, animated: true)
        if langSwitch.isOn {
            for row in 1...(numberOfRows-1) {
                let cell = tableView.cellForRow(at: IndexPath(row: row, section: 1))
                let text = (cell?.textLabel?.text)!
                if (settings?.languages.contains(text))! {
                    cell?.accessoryType = .checkmark
                } else {
                    cell?.accessoryType = .none
                }
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    /*
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let section = indexPath.section
        let row = indexPath.row
        let cell = tableView.cellForRow(at: indexPath)
        
        if (section == 1) {
            if (row != 0) {
                let text = (cell?.textLabel?.text)!
                if (cell?.accessoryType.rawValue == 0) {
                    // for some reason checking accessoryType == .none doesn't work
                    cell?.accessoryType = .checkmark
                    settings?.languages.append(text)
                } else if (cell?.accessoryType.rawValue == 3) {
                    cell?.accessoryType = .none
                    if (settings?.languages.contains(text))! {
                        settings?.languages.remove(at: (settings?.languages.index(of: text))!)
                    }
                }
            }
        }
        
    }
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        self.delegate?.didSaveSettings(settings: settings!)
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        self.delegate?.didCancelSettings()
    }

    @IBAction func sliderChange(_ sender: Any) {
        settings?.minStars = Int(slider.value)
        minStarValue.text = String(Int(slider.value))
    }
    
    @IBAction func langFilterSwitch(_ sender: Any) {
        if (langSwitch.isOn) {
            settings?.langSwitch = true
            javaCell.isHidden = false
            javascriptCell.isHidden = false
            objectivecCell.isHidden = false
            pythonCell.isHidden = false
            rubyCell.isHidden = false
            swiftCell.isHidden = false
        } else {
            settings?.langSwitch = false
            javaCell.isHidden = true
            javascriptCell.isHidden = true
            objectivecCell.isHidden = true
            pythonCell.isHidden = true
            rubyCell.isHidden = true
            swiftCell.isHidden = true
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

protocol SettingsPresentingViewControllerDelegate: class {
    func didSaveSettings(settings: GithubRepoSearchSettings)
    func didCancelSettings()
}
