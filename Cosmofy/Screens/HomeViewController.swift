//  ========================================
//  HomeViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/11/22.
//  Abstract: The main view controller user first see when they launch the app.
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
    @IBOutlet weak var collectionView: UICollectionView!

    @IBOutlet weak var goodLabel: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    var currentCellIndex = 0
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    var name = ""
    let shape = CAShapeLayer()
    let hour = Calendar.current.component(.hour, from: Date())
    
    
    let gradientOne = UIColor.systemTeal.cgColor
    let gradientTwo = UIColor.systemPurple.cgColor
    let gradientThree = UIColor.systemRed.cgColor
    let gradientFour = UIColor.systemIndigo.cgColor
    let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
    
    
    @IBAction func linkButton(_ sender: UIButton) {
        UIApplication.shared.open(URL(string: "https://www.quantamagazine.org/what-is-the-geometry-of-the-universe-20200316?ref=refind")! as URL, options: [:], completionHandler: nil)
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
    
    var arrProductPhotos = [UIImage(named: "20221211_HomeBanner8")!, // Red One
                            UIImage(named: "20230618_HomeBanner2")!, // Blue One
                            UIImage(named: "20221211_HomeBanner6")!, // 1
                            UIImage(named: "20221211_HomeBanner5")!, // 2
                            UIImage(named: "20221211_HomeBanner4")!, // 3
                            UIImage(named: "20221211_HomeBanner7")!] // 4
    var timer : Timer?
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = arrProductPhotos.count
                
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = .zero
        topView.layer.shadowRadius = 1
        
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientFour])
        gradientSet.append([gradientFour, gradientOne])
        animateGradient()
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        name = UserDefaults.standard.object(forKey: "s1") as! String
        
        switch hour {
            case 4...11 : goodLabel.text = "Good Morning ".uppercased()
            case 12...16 : goodLabel.text = "Good Afternoon ".uppercased()
            case 17..<24 : goodLabel.text = "Good Evening ".uppercased()
            default: goodLabel.text = "Good Evening ".uppercased()
        }
        
        goodLabel.text! += name.uppercased()
    }
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        

        topView.layer.cornerRadius = 28+2
        self.topView.clipsToBounds = true
        
        gradient.frame =  CGRect(origin: CGPoint.zero, size: self.topView.frame.size)
        gradient.colors = gradientSet[currentGradient]
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.drawsAsynchronously = true
        
        shape.lineWidth = 2.5
        shape.path = UIBezierPath(roundedRect: topView.bounds.insetBy(dx: 2, dy: 2), byRoundingCorners: [.topLeft, .bottomLeft, .topRight, .bottomRight], cornerRadii: CGSize(width: topView.layer.cornerRadius, height: topView.layer.cornerRadius)).cgPath
        
        shape.strokeColor = UIColor.black.cgColor
        shape.fillColor = UIColor.clear.cgColor
        gradient.mask = shape

        self.topView.layer.addSublayer(gradient)
    }
    
    func animateGradient() {

        switch (currentGradient) {
            case 0: currentGradient = 1
            case 1: currentGradient = 2
            case 2: currentGradient = 3
            case 3: currentGradient = 0
            default: currentGradient = 0
        }
 
        gradientChangeAnimation.delegate = self
        gradientChangeAnimation.duration = 6.0
        gradientChangeAnimation.toValue = gradientSet[currentGradient]
        gradientChangeAnimation.fillMode = CAMediaTimingFillMode.forwards
        gradientChangeAnimation.isRemovedOnCompletion = false
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
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
        
        
        switch (currentCellIndex) {
                
            case 0: label2.text = "Hubble Space Telescope"
            case 1: label2.text = "Hubble Space Telescope"
            case 2: label2.text = "Hubble Space Telescope"
            case 3: label2.text = "Hubble Space Telescope"
            case 4: label2.text = "Hubble Space Telescope"
            case 5: label2.text = "Hubble Space Telescope"
            default: label2.text = "Hubble Space Telescope"
        }
        
        switch (currentCellIndex) {
                
            case 0: label3.text = "Ghostly Star-Forming Pillar of Gas and Dust"
            case 1: label3.text = "The Bubble Nebula"
            case 2: label3.text = "Hubble’s Sharpest View of the Orion Nebula"
            case 3: label3.text = "Antennae Galaxies Reloaded"
            case 4: label3.text = "A Rose Made of Galaxies"
            case 5: label3.text = "Stellar Spire in the Eagle Nebula"
            default: label3.text = ""
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

        switch (currentCellIndex) {
                
            case 0: label2.text = "Hubble Space Telescope"
            case 1: label2.text = "Hubble Space Telescope"
            case 2: label2.text = "Hubble Space Telescope"
            case 3: label2.text = "Hubble Space Telescope"
            case 4: label2.text = "Hubble Space Telescope"
            case 5: label2.text = "Hubble Space Telescope"
            default: label2.text = "Hubble Space Telescope"
        }
        
        switch (currentCellIndex) {
                
            case 0: label3.text = "Ghostly Star-Forming Pillar of Gas and Dust"
            case 1: label3.text = "The Bubble Nebula"
            case 2: label3.text = "Hubble’s Sharpest View of the Orion Nebula"
            case 3: label3.text = "Antennae Galaxies Reloaded"
            case 4: label3.text = "A Rose Made of Galaxies"
            case 5: label3.text = "Stellar Spire in the Eagle Nebula"
            default: label3.text = ""
        }
        
        pageControl.currentPage = currentCellIndex
        timer?.invalidate()
        startTimer(time: 4.5)
    }
    
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        gradient.removeAnimation(forKey: "colorChange")
        
        
    }
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        startTimer(time: 6.0)
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }

}

// MARK: - extension
extension HomeViewController: CAAnimationDelegate {
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if flag {
            gradient.colors = gradientSet[currentGradient]
            animateGradient()
        }
    }
}
