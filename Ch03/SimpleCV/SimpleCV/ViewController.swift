//
//  ViewController.swift
//  SimpleCV
//
//  Created by Tim on 10/01/16.
//  Copyright © 2016 Tim Duckett. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var suitsArray = [Dictionary<String, AnyObject>]()
    @IBOutlet var collectionView: UICollectionView!
    
    enum ParsingError: Error {
        case missingJson
        case jsonParsingError
    }

    override func viewDidLoad() {

        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        // Configure data
        
        do {
            
            try setupData()
            
        } catch ParsingError.missingJson {
            
            print("Error loading JSON")
            
        } catch ParsingError.jsonParsingError {
            
            print("Error parsing JSON")
            
        } catch {
            
            print("Something went wrong")
            
        }
        
        // Configure collection view
        configureCollectionView()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Data setup
    
    func setupData () throws {
            
        guard let filePath = Bundle.main.path(forResource: "cards", ofType: "json"), let jsonData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else {
            throw ParsingError.missingJson
        }
    
        do {
            let parsedObject = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
            suitsArray = parsedObject["suits"] as! Array
        } catch {
            throw ParsingError.jsonParsingError
        }
    }
    
    func configureCollectionView() {
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CardCell")
    }
    
    // MARK: -
    // MARK: UICollectionViewDataSource methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return suitsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let cardsDictionary = self.suitsArray[section]
        let cardsArray = cardsDictionary["cards"] as! NSArray
        return cardsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath)
        
        let suitDictionary = suitsArray[indexPath.section]
        let cardsArray = suitDictionary["cards"] as! [Dictionary<String, AnyObject>]
        let cardDictionary = cardsArray[indexPath.row]
        
        let cardImageName = cardDictionary["cardImage"] as! String
        
        if let cardImage = UIImage(named: cardImageName) {
            
            if let imageView = cell.contentView.viewWithTag(1000) as? UIImageView {
                imageView.image = cardImage
            }
        
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsetsMake(10, 10, 10, 10)
        
    }

}

