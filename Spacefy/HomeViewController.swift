//  ========================================
//  HomeViewController.swift
//  Spacefy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/11/22.
//  ========================================

import UIKit

class HomeViewController: // multiple inheritance
    UIViewController,
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    UICollectionViewDelegateFlowLayout  {
    
    // variables
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    var currentCellIndex = 0
    
    @IBAction func linkButton(_ sender: UIButton) {
        
        UIApplication.shared.open(URL(string: "https://bit.ly/SpacefyArticle")! as URL, options: [:], completionHandler: nil)
        
    }
    
    
    @IBAction func dynamicButton(_ sender: Any) {
        
        if (currentCellIndex == 0) {
            UIApplication.shared.open(URL(string: "https://esahubble.org/images/heic0206c/")! as URL, options: [:], completionHandler: nil)
        } else if (currentCellIndex == 1) {
            UIApplication.shared.open(URL(string: "https://esahubble.org/images/heic0601a/")! as URL, options: [:], completionHandler: nil)
        }
        else if (currentCellIndex == 2) {
            UIApplication.shared.open(URL(string: "https://esahubble.org/images/potw1345a/")! as URL, options: [:], completionHandler: nil)
        }
        else if (currentCellIndex == 3) {
            UIApplication.shared.open(URL(string: "https://esahubble.org/images/heic1107a/")! as URL, options: [:], completionHandler: nil)
        }
        else if (currentCellIndex == 4) {
            UIApplication.shared.open(URL(string: "https://esahubble.org/images/heic0506b/")! as URL, options: [:], completionHandler: nil)
        }

    }
    
    
    
    var arrProductPhotos = [UIImage(named: "20221211_HomeBanner8")!, // 0
                            UIImage(named: "20221211_HomeBanner6")!, // 1
                            UIImage(named: "20221211_HomeBanner5")!, // 2
                            UIImage(named: "20221211_HomeBanner4")!, // 3
                            UIImage(named: "20221211_HomeBanner7")!] // 4
    var timer : Timer?
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = arrProductPhotos.count
        
        topView.layer.borderColor = UIColor.black.cgColor
        topView.layer.borderWidth = 1
        
        bottomView.layer.borderColor = UIColor.black.cgColor
        bottomView.layer.borderWidth = 1
        
        topView.layer.shadowColor = UIColor.white.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = .zero
        topView.layer.shadowRadius = 1
        
        bottomView.layer.shadowColor = UIColor.white.cgColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 1
    
        startTimer(time: 6.0)
        
    }
    
    override func viewDidLayoutSubviews() {
        bottomView.layer.cornerRadius = 24
        topView.layer.cornerRadius = 24
    }
    
    func startTimer(time: Double) {
        timer = Timer.scheduledTimer(timeInterval: time, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if (currentCellIndex < arrProductPhotos.count - 1) {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
        
        if (currentCellIndex == 0) { // 3
            label1.text = "Hubble's Top 100" // 21
            label2.text = "Ghostly Star-Forming Pillar of Gas and Dust"
        } else if (currentCellIndex == 1) { // 4
            label1.text = "Hubble's Top 100" // 2
            label2.text = "Hubble’s Sharpest View of the Orion Nebula"
        } else if (currentCellIndex == 2) { // 5
            label1.text = "Hubble's Top 100" // 4
            label2.text = "Antennae Galaxies Reloaded"
        } else if (currentCellIndex == 3) { // 6
            label1.text = "Hubble's Top 100" // 12
            label2.text = "A Rose Made of Galaxies"
        } else if (currentCellIndex == 4) { // 7
            label1.text = "Hubble's Top 100" // 15
            label2.text = "Stellar Spire in the Eagle Nebula"
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrProductPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "homeCell", for: indexPath) as! HomeCollectionViewCell
        cell.homeImage.image = arrProductPhotos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentCellIndex = Int(scrollView.contentOffset.x / width)

        if (currentCellIndex == 0) { // 3
            label1.text = "Hubble's Top 100" // 21
            label2.text = "Ghostly Star-Forming Pillar of Gas and Dust"
        } else if (currentCellIndex == 1) { // 4
            label1.text = "Hubble's Top 100" // 2
            label2.text = "Hubble’s Sharpest View of the Orion Nebula"
        } else if (currentCellIndex == 2) { // 5
            label1.text = "Hubble's Top 100" // 4
            label2.text = "Antennae Galaxies Reloaded"
        } else if (currentCellIndex == 3) { // 6
            label1.text = "Hubble's Top 100" // 12
            label2.text = "A Rose Made of Galaxies"
        } else if (currentCellIndex == 4) { // 7
            label1.text = "Hubble's Top 100" // 15
            label2.text = "Stellar Spire in the Eagle Nebula"
        }
        pageControl.currentPage = currentCellIndex

        timer?.invalidate()
        startTimer(time: 4.5)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}
