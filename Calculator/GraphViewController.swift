//
//  GraphViewController.swift
//  GraphicCalculator
//
//  Created by Алексей Саблин on 21.11.2021.
//

import UIKit

class GraphViewController: UIViewController {
    
    // Model
    var yForX: ((Double) -> Double?)? { didSet { updateUI() } }
    
    // View
    
    @IBOutlet weak var graphView: GraphView! { didSet {
        graphView.addGestureRecognizer(UIPinchGestureRecognizer(target: graphView, action: #selector(GraphView.scale(_:))))
        
        graphView.addGestureRecognizer(UIPanGestureRecognizer(target: graphView, action: #selector(GraphView.originMove(_:))))
        
        let doubleTapRecognizer = UITapGestureRecognizer(target: graphView, action: #selector(GraphView.origin(_:)))
        
        doubleTapRecognizer.numberOfTapsRequired = 2
        graphView.addGestureRecognizer(doubleTapRecognizer)
        
        updateUI()
        }
    }
    
    func updateUI() {
        graphView?.yForX = yForX
    }
}
