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
     

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
/*/
 
 This is going to house a small collection view of grid presets, maybe with a small photo showing what each one looks like
 
 */
extension GameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
