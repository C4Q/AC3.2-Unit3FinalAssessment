//
//  RecordViewController.swift
//  VictoriaAlbert
//
//  Created by Victor Zhong on 11/10/16.
//  Copyright © 2016 Victor Zhong. All rights reserved.
//

import UIKit

class RecordViewController: UIViewController {
    
    @IBOutlet weak var recordImage: UIImageView!
    @IBOutlet weak var recordTitle: UILabel!
    @IBOutlet weak var recordLabel: UILabel!
    var recordSelected: Record?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    //MARK: - Load Data
    
    func loadData() {
        guard let validRecord = recordSelected else { return }
        
        APIRequestManager.manager.getData(endPoint: validRecord.imageBig) { (data: Data?) in
            if  let validData = data,
                let validImage = UIImage(data: validData) {
                DispatchQueue.main.async {
                    self.recordImage.image = validImage
                }
            }
        }
        var recordLabelTextString = "\(validRecord.object), \(validRecord.date)"
        if validRecord.place != "" {
            recordLabelTextString += " - \(validRecord.place)"
        }
        self.recordTitle.text = validRecord.title
        self.recordLabel.text = recordLabelTextString
    }
}

