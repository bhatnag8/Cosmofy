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
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    let shape = CAShapeLayer()
    
    let gradient2 = CAGradientLayer()
    var gradientSet2 = [[CGColor]]()
    var currentGradient2: Int = 0
    let shape2 = CAShapeLayer()
    
    let gradientOne = UIColor.systemTeal.cgColor
    let gradientTwo = UIColor.systemPurple.cgColor
    let gradientThree = UIColor.systemRed.cgColor
    
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
    
    var arrProductPhotos = [UIImage(named: "20221211_HomeBanner3")!,
                            UIImage(named: "20221211_HomeBanner3")!, // 0
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
        
//        bottomView.layer.borderColor = UIColor.black.cgColor
//        bottomView.layer.borderWidth = 1
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = .zero
        topView.layer.shadowRadius = 1
        
        bottomView.layer.shadowColor = UIColor.black.cgColor
        bottomView.layer.shadowOpacity = 1
        bottomView.layer.shadowOffset = .zero
        bottomView.layer.shadowRadius = 1
        
    }
    
    override func viewDidLayoutSubviews() {
        bottomView.layer.cornerRadius = topView.bounds.height / 2
        topView.layer.cornerRadius = topView.bounds.height / 2
        
        self.topView.clipsToBounds = true
        self.bottomView.clipsToBounds = true
        
        gradientSet.append([gradientOne, gradientOne, gradientTwo])
        gradientSet.append([gradientOne, gradientTwo, gradientTwo])
        gradientSet.append([gradientTwo, gradientTwo, gradientThree])
        gradientSet.append([gradientTwo, gradientThree, gradientThree])
        gradientSet.append([gradientThree, gradientThree, gradientOne])
        gradientSet.append([gradientThree, gradientOne, gradientOne])
        
        gradientSet2.append([gradientOne, gradientTwo, gradientTwo])
        gradientSet2.append([gradientTwo, gradientTwo, gradientThree])
        gradientSet2.append([gradientTwo, gradientThree, gradientThree])
        gradientSet2.append([gradientThree, gradientThree, gradientOne])
        gradientSet2.append([gradientThree, gradientOne, gradientOne])
        gradientSet2.append([gradientOne, gradientOne, gradientTwo])

        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.topView.frame.size)
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.drawsAsynchronously = true
        
        gradient2.frame =  CGRect(origin: CGPoint.zero, size: self.bottomView.frame.size)
        gradient2.colors = gradientSet2[currentGradient2]
        gradient2.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient2.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient2.drawsAsynchronously = true

        shape.lineWidth = 2.5
        shape.path = UIBezierPath(roundedRect: topView.bounds.insetBy(dx: 2, dy: 2), byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: topView.layer.cornerRadius, height: topView.layer.cornerRadius)).cgPath
        
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape
        
        shape2.lineWidth = 2.5
        shape2.path = UIBezierPath(roundedRect: bottomView.bounds.insetBy(dx: 2, dy: 2), byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: bottomView.layer.cornerRadius, height: bottomView.layer.cornerRadius)).cgPath
        
        shape2.strokeColor = UIColor.black.cgColor
        shape2.fillColor = UIColor.clear.cgColor
        gradient2.mask = shape2
        
        self.topView.layer.addSublayer(gradient)
        self.bottomView.layer.addSublayer(gradient2)
        animateGradient()
    }
    
    func animateGradient() {
        if currentGradient < gradientSet.count - 1 {
            currentGradient += 1
        } else {
            currentGradient = 0
        }
        
        if currentGradient2 < gradientSet2.count - 1 {
            currentGradient2 += 1
        } else {
            currentGradient2 = 0
        }
        
        let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation.duration = 6.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
        
        let gradientChangeAnimation2 = CABasicAnimation(keyPath: "colors")
        gradientChangeAnimation2.duration = 6.0
        gradientChangeAnimation2.toValue = gradientSet2[currentGradient2]
        gradientChangeAnimation2.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation2.isRemovedOnCompletion = false
        gradient2.add(gradientChangeAnimation2, forKey: "colorChange")
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
            label2.text = "New Stars Shed Light on the Past"
        } else if (currentCellIndex == 1) { // 4
            label1.text = "Hubble's Top 100" // 21
            label2.text = "Ghostly Star-Forming Pillar of Gas and Dust"
        } else if (currentCellIndex == 2) { // 4
            label1.text = "Hubble's Top 100" // 2
            label2.text = "Hubble’s Sharpest View of the Orion Nebula"
        } else if (currentCellIndex == 3) { // 5
            label1.text = "Hubble's Top 100" // 4
            label2.text = "Antennae Galaxies Reloaded"
        } else if (currentCellIndex == 4) { // 6
            label1.text = "Hubble's Top 100" // 12
            label2.text = "A Rose Made of Galaxies"
        } else if (currentCellIndex == 5) { // 7
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
            label2.text = "New Stars Shed Light on the Past"
        } else if (currentCellIndex == 1) { // 4
            label1.text = "Hubble's Top 100" // 21
            label2.text = "Ghostly Star-Forming Pillar of Gas and Dust"
        } else if (currentCellIndex == 2) { // 4
            label1.text = "Hubble's Top 100" // 2
            label2.text = "Hubble’s Sharpest View of the Orion Nebula"
        } else if (currentCellIndex == 3) { // 5
            label1.text = "Hubble's Top 100" // 4
            label2.text = "Antennae Galaxies Reloaded"
        } else if (currentCellIndex == 4) { // 6
            label1.text = "Hubble's Top 100" // 12
            label2.text = "A Rose Made of Galaxies"
        } else if (currentCellIndex == 5) { // 7
            label1.text = "Hubble's Top 100" // 15
            label2.text = "Stellar Spire in the Eagle Nebula"
        }
        pageControl.currentPage = currentCellIndex

        timer?.invalidate()
        startTimer(time: 4.5)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startTimer(time: 6.0)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

extension HomeViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            gradient2.colors = gradientSet2[currentGradient2]
            animateGradient()
        }
    }
}
