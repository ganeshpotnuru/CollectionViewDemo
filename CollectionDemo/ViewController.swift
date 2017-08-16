//
//  ViewController.swift
//  CollectionDemo
//
//  Created by Ganesh Potnuru on 8/7/17.
//  Copyright © 2017 Ganesh Potnuru. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView?
    internal var arrPhotos = [Album]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        getAlbums()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getAlbums() {
        APIManager.fetchInformation(withUrl: "https://jsonplaceholder.typicode.com/photos", params: nil, succesResponse: { (json, statuscode) in
            
            self.arrPhotos.removeAll()
            self.arrPhotos = json.arrayValue.map { return Album(with: $0)
                self.collectionView?.reloadData()
            }
            print(self.arrPhotos.count)
        }) { (error) in
            let alertVC = UIAlertController(title: "Error", message: error.description, preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertVC.addAction(alertAction)
            self.present(alertVC, animated: true, completion: nil)
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath)
        cell.backgroundColor = UIColor.black
        return cell
    }
}

