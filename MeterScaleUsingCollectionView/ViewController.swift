//
//  ViewController.swift
//  MeterScaleUsingCollectionView


import UIKit
/**
 * This class belongs to generate scale and showing scale value using collection view
 **/
class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var markerView: UIView!
    @IBOutlet weak var meterView: UIView!
    @IBOutlet weak var scaleValueLabel: UILabel!
    @IBOutlet weak var collectionViewObj: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if(!decelerate)
        {
            updateScaleValue()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        updateScaleValue()
    }
    
    func updateScaleValue() {
        let center = self.meterView.convert(self.collectionViewObj.center, to: self.collectionViewObj)
        let index = collectionViewObj!.indexPathForItem(at: center)
        let cell = self.collectionViewObj.cellForItem(at: index!)!
        let CellFrameInView = self.collectionViewObj.convert(cell.frame, to: self.meterView)
        let completeValue:Int = (index!.row * 10)
        let remainingUnit:Int =  (Int((markerView.frame.origin.x - CellFrameInView.origin.x)/7)+1)
        let scaleValue = completeValue + remainingUnit
        self.scaleValueLabel.text="Height: \(scaleValue)"
    }
}

extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let unitValue=(indexPath.row+1)*10
       cell.unitValueLabel.text="\(unitValue)"
   
    return cell
}
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        // calculate the insets and return a UIEdgeInsets
    }

    
}
