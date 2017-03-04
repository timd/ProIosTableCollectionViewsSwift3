//
//  ClockViewController.swift
//  SwiftClock
//
//  Created by Tim on 21/04/15.
//  Copyright (c) 2015 Tim Duckett. All rights reserved.
//

import UIKit

class ClockViewController: UIViewController {
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var timeLabel: UILabel!
    
    let HourCellView = "HourCellView"
    let HourHandCell = "HourHandCell"
    let MinsHandCell = "MinsHandCell"
    let SecsHandCell = "SecsHandCell"

    var clockLayout: ClockLayout!
    
    var dataArray: Array<Array<String>>!
    
    var tickTimer: Timer!
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        setupData()
        
        configureCollectionView()
        
        tickTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ClockViewController.updateClock), userInfo: nil, repeats: true)
        
        RunLoop.current.add(tickTimer, forMode: RunLoopMode.commonModes)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        tickTimer.invalidate()
        
    }
    
}

extension ClockViewController {
    
    
    func setupData() {
        
        let handsArray = ["hours", "minutes", "seconds"]
        let hoursArray = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]

        dataArray = [handsArray, hoursArray]
        
    }
    
    func configureCollectionView() {
        
        collectionView.register(UINib(nibName: "HourCell", bundle: nil), forCellWithReuseIdentifier: HourCellView)
        collectionView.register(HandCell.self, forCellWithReuseIdentifier: HourHandCell)
        collectionView.register(HandCell.self, forCellWithReuseIdentifier: MinsHandCell)
        collectionView.register(HandCell.self, forCellWithReuseIdentifier: SecsHandCell)

        clockLayout = ClockLayout()
        collectionView.setCollectionViewLayout(clockLayout, animated: false)

        clockLayout.hourLabelCellSize = CGSize(width: 100.0, height: 100.0)
        clockLayout.hourHandSize = CGSize(width: 10.0, height: 140.0)
        clockLayout.minuteHandSize = CGSize(width: 10.0, height: 200.0)
        clockLayout.secondHandSize = CGSize(width: 6.0, height: 200.0)

    }

    func updateClock() {

        let currentTime = Date()
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        let timeString = formatter.string(from: currentTime)
        
        timeLabel.text = timeString
        
        collectionView.collectionViewLayout.invalidateLayout()
        
    }
    
}

extension ClockViewController : UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        let innerArray = self.dataArray[section]
        
        return innerArray.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell: UICollectionViewCell!
        
        // Handle time labels
        switch (indexPath.section) {
            
        case 0: // Handle hands
            
            switch (indexPath.row) {
                
            case 0: // Handle hour hands
                
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourHandCell, for: indexPath) as! HandCell
                let hourHandView = UIView(frame: CGRect(x: 0, y: 0, width: clockLayout.hourHandSize.width, height: clockLayout.hourHandSize.height))
                hourHandView.backgroundColor = UIColor.black
                cell.contentView.addSubview(hourHandView)
                cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
                
            case 1: // handle minute hands
                
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: MinsHandCell, for: indexPath) as! HandCell
                let minuteHandView = UIView(frame: CGRect(x: 0, y: 0, width: clockLayout.minuteHandSize.width, height: clockLayout.minuteHandSize.height))
                minuteHandView.backgroundColor = UIColor.black
                cell.contentView.addSubview(minuteHandView)
                cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
                
            default: // handle second hands
                
                cell = collectionView.dequeueReusableCell(withReuseIdentifier: SecsHandCell, for: indexPath)
                let secondHandView = UIView(frame: CGRect(x: 0, y: 0, width: clockLayout.secondHandSize.width, height: clockLayout.secondHandSize.height))
                secondHandView.backgroundColor = UIColor.red
                cell.contentView.addSubview(secondHandView)
                cell.layer.anchorPoint = CGPoint(x: 0.5, y: 0.9)
                
            }
            
        default: // Handle hours labels
            
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourCellView, for: indexPath) as UICollectionViewCell
            
            let hourLabelsArray = dataArray[1]
            let hoursText = hourLabelsArray[indexPath.row]
            
            if let cellLabel: UILabel = cell.viewWithTag(1000) as? UILabel {
                cellLabel.text = hoursText
            }
            
        }
        
        return cell
        
    }
    
}

