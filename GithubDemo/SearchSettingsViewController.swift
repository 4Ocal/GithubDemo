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
    
    var checked: [Bool] = []
    var settings: GithubRepoSearchSettings?
    var settingsCopy: GithubRepoSearchSettings?

    weak var delegate: SettingsPresentingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        slider.value = Float(settings!.minStars)
        slider.sendActions(for: UIControlEvents.valueChanged)
        //langSwitch.isOn = defaults.bool(forKey: "langSwitch")
        //langSwitch.sendActions(for: UIControlEvents.valueChanged)
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
                if (cell?.accessoryType.rawValue == 0) {
                    // for some reason checking accessoryType == .none doesn't work
                    cell?.accessoryType = .checkmark
                } else if (cell?.accessoryType.rawValue == 3) {
                    cell?.accessoryType = .none
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
    /*
    @IBAction func save(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(Int(slider.value), forKey: "minStars")
        defaults.set(langSwitch.isOn, forKey: "langSwitch")
        defaults.synchronize()
        self.dismiss(animated: true, completion: {})
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: {})
    }
    */
    @IBAction func sliderChange(_ sender: Any) {
        settings?.minStars = Int(slider.value)
        minStarValue.text = String(Int(slider.value))
    }
    
    @IBAction func langFilterSwitch(_ sender: Any) {
        if (langSwitch.isOn) {
            javaCell.isHidden = false
            javascriptCell.isHidden = false
            objectivecCell.isHidden = false
            pythonCell.isHidden = false
            rubyCell.isHidden = false
            swiftCell.isHidden = false
        } else {
            javaCell.isHidden = true
            javascriptCell.isHidden = true
            objectivecCell.isHidden = true
            pythonCell.isHidden = true
            rubyCell.isHidden = true
            swiftCell.isHidden = true
            
        }
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

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
