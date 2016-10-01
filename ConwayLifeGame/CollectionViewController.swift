//
//  CollectionViewController.swift
//  ConwayLifeGame
//
//  Created by jinx on 16/6/8.
//  Copyright © 2016年 jinxscorpio. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class CollectionViewController: UICollectionViewController {
    
    let cellWH = 20
    var countCol = 0
    var countRow = 0
    var arrayTmp = [Int]()
    var timer:Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true);
        
        
        timer = Timer.scheduledTimer(timeInterval: 0.3, target:self,selector:#selector(CollectionViewController.changeLife), userInfo:nil,repeats:true)
    
    }
    
    func changeLife() {
        
        let cellCount = arrayTmp.count
        var decisionMaker = 0
        var decisionMakers = [0, 0, 0, 0, 0, 0, 0, 0]
            
        for index in 0...cellCount - 1 {
            
            if index - countCol - 1 < 0 {
                if 0 == arc4random() % 2 {
                    decisionMakers[0] = 1
                } else {
                    decisionMakers[0] = 0
                }
            } else {
                decisionMakers[0] = arrayTmp[index - countCol - 1]
            }
            
            if index - countCol < 0 {
                if 0 == arc4random() % 2 {
                    decisionMakers[1] = 1
                } else {
                    decisionMakers[1] = 0
                }
            } else {
                decisionMakers[1] = arrayTmp[index - countCol]
            }
            
            if index - countCol + 1 < 0 {
                if 0 == arc4random() % 2 {
                    decisionMakers[2] = 1
                } else {
                    decisionMakers[2] = 0
                }
            } else {
                decisionMakers[2] = arrayTmp[index - countCol + 1]
            }
            
            if index - 1 < 0 {
                if 0 == arc4random() % 2 {
                    decisionMakers[3] = 1
                } else {
                    decisionMakers[3] = 0
                }
            } else {
                decisionMakers[3] = arrayTmp[index - 1]
            }
            
            if index + 1 > cellCount - 1 {
                if 0 == arc4random() % 2 {
                    decisionMakers[4] = 1
                } else {
                    decisionMakers[4] = 0
                }
            } else {
                decisionMakers[4] = arrayTmp[index + 1]
            }
            
            if index + countCol - 1 > cellCount - 1 {
                if 0 == arc4random() % 2 {
                    decisionMakers[5] = 1
                } else {
                    decisionMakers[5] = 0
                }
            } else {
                decisionMakers[5] = arrayTmp[index + countCol - 1]
            }
            
            if index + countCol > cellCount - 1 {
                if 0 == arc4random() % 2 {
                    decisionMakers[6] = 1
                } else {
                    decisionMakers[6] = 0
                }
            } else {
                decisionMakers[6] = arrayTmp[index + countCol]
            }
            
            if index + countCol + 1  > cellCount - 1 {
                if 0 == arc4random() % 2 {
                    decisionMakers[7] = 1
                } else {
                    decisionMakers[7] = 0
                }
            } else {
                decisionMakers[7] = arrayTmp[index + countCol + 1]
            }
            
            for tmp in decisionMakers {
                decisionMaker += tmp
            }
            
            if decisionMaker < 2 || decisionMaker > 3 {
                self.collectionView?.cellForItem(at: IndexPath(item:index, section:0))?.tag = 0
                self.collectionView?.cellForItem(at: IndexPath(item:index, section:0))?.backgroundColor = UIColor.white
            }
            if decisionMaker == 3 {
                self.collectionView?.cellForItem(at: IndexPath(item:index, section:0))?.tag = 1
                self.collectionView?.cellForItem(at: IndexPath(item:index, section:0))?.backgroundColor = UIColor.green
            }
            
            print("index:\(index) :: array \(arrayTmp[index]) :: \(self.collectionView?.cellForItem(at: IndexPath(item:index, section:0))?.tag)")
            decisionMaker = 0
        }
            
        for index1 in 0...cellCount - 1 {
            arrayTmp[index1] = (self.collectionView?.cellForItem(at: IndexPath(item:index1, section:0))?.tag)!
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    func collectionView(_ collectionView: UICollectionView!, layout collectionViewLayout: UICollectionViewLayout!, sizeForItemAtIndexPath indexPath: IndexPath!) -> CGSize{
        
        return CGSize(width: CGFloat(cellWH), height: CGFloat(cellWH))
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        
        countCol = Int(Int(self.view.frame.width) / cellWH)
        countRow = Int(Int(self.view.frame.height) / cellWH)
        
        return countCol * countRow
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
        
        if 0 == arc4random() % 2 {
            cell.backgroundColor = UIColor.green
            cell.tag = 1
            arrayTmp.append(1)
        } else {
            cell.backgroundColor = UIColor.white
            cell.tag = 0
            arrayTmp.append(0)
        }
        
        return cell
    }
    
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */

}
