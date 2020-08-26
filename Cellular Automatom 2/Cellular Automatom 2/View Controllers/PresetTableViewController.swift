//
//  PresetTableViewController.swift
//  Cellular Automatom 2
//
//  Created by Joseph Veverka on 8/26/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class PresetTableViewController: UITableViewController {
    
    //MARK: - Properties
    var heightForColorRow : CGFloat = 84
    var heightForPatternRow: CGFloat = 42
    var currentSelectedPresetIndex: Int = -1
    var mainVC: MainScreenViewController?
    
    // All preset methods from Models/ViewModels/"PresetModels.swift"
    let allPresets = [
        Blinker(),
        TrafficLight(),
        Watch(),
        Pulsar(),
        Acorn(),
        Octagon(),
        Galaxy(),
        Pentadecathlon(),
        Glider(),
        DieHard(),
        SpaceShipHeavyWeight(),
        SchickEngineB(),
        SchickEngineT(),
        Random()
    ]
    
    //MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
    }
    
    //MARK: - Class Functions
    
    @objc func dismissVC() {
        
        if self.currentSelectedPresetIndex >= 0  && self.mainVC != nil {
            
            GameOfLife.shared.clear()
            GameOfLife.shared.setOscillator(oscillator: allPresets[self.currentSelectedPresetIndex])
            
        }
        
        self.mainVC?.viewWillAppear(false)
        self.dismiss(animated: true)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section ==  1 {
            return allPresets.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let cell = tableView.cellForRow(at:indexPath)
            cell?.accessoryType = .checkmark
            self.currentSelectedPresetIndex = indexPath.row
        }
        else {
            
            let cell = tableView.cellForRow(at:indexPath)
            cell?.accessoryType = .checkmark
            self.currentSelectedPresetIndex = indexPath.row
            
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            
            return heightForColorRow
        }
            
        else {
            
            return heightForPatternRow
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section  == 0 {
            return String("Choose a color!")
        }
        else {
            return String("Choose a pattern!")
            
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.selectionStyle = .none
            let oscillator = self.allPresets[indexPath.row]
            cell.textLabel?.text = oscillator.name
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "colorCell", for: indexPath)
            return cell
        }
    }
    
}
