//
//  MainScreenViewController.swift
//  Cellular Automatom 2
//
//  Created by Joseph Veverka on 8/26/20.
//  Copyright © 2020 Joseph Veverka. All rights reserved.
//

import UIKit

class MainScreenViewController: UIViewController {
    
    //MARK: - IBOutlets
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Properties ##
    var timer = Timer()
    var isRunning = false
    var objects = [Any]()
    let columns: Int = GameOfLife.shared.columns
    let rows: Int = GameOfLife.shared.rows
    
    
    //MARK: - View Lifecycle ##
    override func viewDidLoad() {
        super.viewDidLoad()
        

        setupCollectionView()
        setupStartButton()
        let addPresetButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.refreshCells))
        self.navigationItem.rightBarButtonItem = addPresetButton
        let deleteGridButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(self.clearCells))
        self.navigationItem.leftBarButtonItem = deleteGridButton
        addPresetButton.tintColor = .systemPink
        deleteGridButton.tintColor = .systemPink
        

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if animated == false {
            self.collectionView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureCollectionViewFlowLayout()
        
    }
    
    //MARK: - IBActions
    
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
        toggleState()
    }
    
    
    //MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showSettingSegue") {
            
            ((segue.destination as! UINavigationController).topViewController as! PresetTableViewController).mainVC = self
        }
    }
    
    //MARK: - Class Functions ##
    
    @objc
    func refreshCells () {
        if isRunning {
            toggleState();
        }
        performSegue(withIdentifier: "showSettingSegue", sender: nil)
    }
    
    @objc
    func clearCells() {
        GameOfLife.shared.clear()
        self.collectionView.reloadData()
        if isRunning {
            toggleState();
        }
    }
    
    func toggleState() {
        
        if !isRunning {
            
            timer = Timer.scheduledTimer(withTimeInterval: 0.3,
                                         repeats: true,
                                         block: {
                                            (timer) in
                                            
                                            if GameOfLife.shared.checkLife() == 0 {
                                                if self.isRunning {
                                                    timer.invalidate()
                                                    self.toggleState()
                                                }
                                            }
                                            
                                            self.collectionView.reloadData()
            })
            
            isRunning = true
            self.startButton.setTitle("Stop", for: .normal)

        }
        else {
            
            isRunning = false
            timer.invalidate()
            self.startButton.setTitle("Start", for: .normal)
        }
    }
    
    // Button Setup
    func setupStartButton() {
        
        self.startButton.layer.cornerRadius = 15
        self.startButton.tintColor = UIColor.white
        self.startButton.setTitle("Start Game!", for: .normal)
        self.setButtonColor()
    }
    
    func configureCollectionViewFlowLayout() {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical //.horizontal
        
        let rect:CGRect = self.collectionView.frame
        
        let width = rect.size.width / CGFloat(columns)
        let height = rect.size.width / CGFloat(columns)
        layout.itemSize = CGSize(width:width,  height: height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .clear
        collectionView.reloadData()
        collectionView.isHidden = false
        
        
    }
    
    func setBackgroundGradient() -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = view.bounds
        layer.colors = [UIColor.blue.cgColor, UIColor.systemPink.cgColor]
        layer.startPoint = CGPoint(x: 0,y: 0)
        layer.endPoint = CGPoint(x: 1,y: 1)
        view.layer.addSublayer(layer)
        
        return layer
    }
    
    // Setup collection view (Grid)
    func setupCollectionView() {
        
        //DataSource/Delegate
        collectionView.delegate = self
        collectionView.dataSource = self
        // CollectionView UI Method
        collectionView.layer.borderColor = self.cellBorderColors()
    }
    
    // Some view methods
    internal func setButtonColor() {
        
        if traitCollection.userInterfaceStyle == .dark {
            
            self.startButton.layer.borderColor = UIColor.white.cgColor
            
        }
            
        else {
            
            self.startButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
    internal func cellBorderColors() -> CGColor {
        
        if traitCollection.userInterfaceStyle == .dark  {
            
            return UIColor.lightGray.cgColor
            
        } else {
            
            return UIColor.darkGray.cgColor
        }
    }
    
    // Dark Mode
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        self.setButtonColor()
    }
}

extension MainScreenViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return columns * rows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        // View Attributes
        cell.layer.borderColor = self.cellBorderColors()
        cell.layer.borderWidth = 0.7
        
        // Cell Color
        if GameOfLife.shared.getStatus(index: indexPath.item)
            
        {
            
            cell.backgroundColor = CellColorHelper.shared.cellColor
            
        }
            
        else
            
        {
            
            cell.backgroundColor = .systemBackground
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let gameStatus = !GameOfLife.shared.getStatus(index: indexPath.item)
        
        GameOfLife.shared.setStatus(index: indexPath.item, status: gameStatus)
        
        self.collectionView.reloadData()
        
    }
}
