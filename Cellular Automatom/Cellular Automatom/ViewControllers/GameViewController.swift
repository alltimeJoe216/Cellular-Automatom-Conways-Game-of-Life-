//
//  GameViewController.swift
//  Cellular Automatom
//
//  Created by Joseph Veverka on 8/24/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

/*
 where grid will be implemented.
 need a segue to a rules page or something of the like.
 a Timer() will *i think* be how we can speed and slow down generations per second etc
 segmented control for a couple different presets?
 
 button for tapping to next generation
 button for reset
 
 
 */

class GameViewController: UIViewController {
    
    //MARK: - Class Properties
    var gridView: GridView!
    var genSpeedTimer = Timer()
    var gameIsRunning = false
    let presetView = UIView()
    var presetTableView = UITableView()
    var label = UILabel()
    
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(updateTitle), name: .generationChanged, object: nil)
        self.gridView = GridView(gridWidth: self.view.frame.width, gridHeight: self.view.frame.height, gridView: self.view)
        configurePresets()
        setupPreset()
        configureCurrentPresetLabel()
        setupTableView()
        configurePresetBar()
        configureCurrentPresetView(index: 0)
    }
    
    @objc func updateTitle(_ notification: NSNotification ) {
        if let dict = notification.userInfo {
            if let id = dict["generations"] as? Int {
                if id == 0{
                    title = "Game of Life"
                } else {
                    title = "\(id) Generations"
                }
            }
        }
    }
    
    //MARK: - IBActions
    @IBOutlet weak var resetButton: UIButton!
    
    @IBAction func resetButton(_ sender: UIButton) {
    }
    
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Grid and Cell Related Functions
    
    func configureCurrentPresetLabel() {
        label.text = "Current Brush: Dot"
        label.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: resetButton.bottomAnchor, constant: 5),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
        ])
        
    }
    
        func configureCurrentPresetView(index: Int) {
            if gridView.currentPreset != nil { gridView.currentPreset.removeFromSuperview() }
            let selectedPreset = gridView.presets[index]
            let preset = ShapePreset(size: selectedPreset.size, cellWidth: selectedPreset.cellWidth, presetStyle: selectedPreset.starterPreset)
            gridView.currentPreset = preset
            preset.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(preset)
    
            NSLayoutConstraint.activate([
                preset.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 5),
                preset.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -preset.frame.width / 2)
            ])
    
            label.text = "Current Brush: " + gridView.currentPreset.starterPreset.rawValue.capitalized
        }
    
    func configurePresetBar() {
        presetView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(presetView)
        presetView.backgroundColor = .clear
        NSLayoutConstraint.activate([
            presetView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            presetView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            presetView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            presetView.topAnchor.constraint(equalTo: gridView.bottomGrid[24][24].bottomAnchor)
        ])
    }
    
    func setupPreset() {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            self.presetView.topAnchor.constraint(equalTo: tableView.topAnchor),
            self.presetView.bottomAnchor.constraint(equalTo: tableView.bottomAnchor),
            self.presetView.leadingAnchor.constraint(equalTo: tableView.leadingAnchor),
            self.presetView.trailingAnchor.constraint(equalTo: tableView.trailingAnchor),
        ])
        self.presetTableView = tableView
    }
    
    func setupTableView() {
        self.presetTableView.dataSource = self
        self.presetTableView.delegate = self
        self.presetTableView.allowsSelection = true
        self.presetTableView.register(PresetCell.self, forCellReuseIdentifier: "PresetCell")
        presetTableView.backgroundColor = .clear
    }
    
    
    
    func configurePresets() {
        gridView.presets.append(ShapePreset(size: 1, cellWidth: gridView.cellDims, presetStyle: .singleCell))
        gridView.presets.append(ShapePreset(size: 2, cellWidth: gridView.cellDims, presetStyle:  .block))
        gridView.presets.append(ShapePreset(size: 3, cellWidth: gridView.cellDims, presetStyle:  .glider))
        gridView.presets.append(ShapePreset(size: 1, cellWidth: gridView.cellDims, presetStyle: .random))
    }
    
}


/*/
 
 This is going to house a small collection view of grid presets, maybe with a small photo showing what each one looks like
 
 */
extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return gridView.presets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PresetCell", for: indexPath) as! PresetCell
        
        cell.set(preset: gridView.presets[indexPath.row])
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        configureCurrentPresetView(index: indexPath.row)
        
        
        if indexPath.row == 6 {
            
            gridView.initNewGrid(grid: gridView.bottomGrid)
            
            for x in 0...49 {
                
                for y in 0...49 {
                    
                    let randomInt = Int.random(in: 0...4)
                    if randomInt == 1 {
                        gridView.bottomGrid[x][y].birthACell()
                        
                    }
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
}

