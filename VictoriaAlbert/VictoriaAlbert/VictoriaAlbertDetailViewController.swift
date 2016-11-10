//
//  VictoriaAlbertDetailViewController.swift
//  VictoriaAlbert
//
//  Created by Tom Seymour on 11/10/16.
//  Copyright © 2016 C4Q-3.2. All rights reserved.
//

import UIKit

class VictoriaAlbertDetailViewController: UIViewController {
    
    var thisMT: MuseumThing!
    
    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDetalView()
    }
    
    func loadDetalView() {
        navigationItem.title = thisMT.object
        textLabel.text = "\(thisMT.title)\nTime Period: \(thisMT.dateMade), Place: \(thisMT.placeMade)\nCurrent Location: \(thisMT.location)\nObject Number: \(thisMT.objectNumber)"
        
        APIHelper.manager.getData(endPoint: thisMT.fullImageString) { (data: Data?) in
            guard let unwrappedData = data else { return }
            DispatchQueue.main.async {
                self.fullImageView.image = UIImage(data: unwrappedData)
                self.view.reloadInputViews()
            }
        }
    }
    
}
