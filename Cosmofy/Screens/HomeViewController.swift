//  ========================================
//  HomeViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 12/11/22.
//  Abstract: The main view controller user first see when they launch the app.
//  ========================================

import UIKit
import SwiftUI
import CloudKit
import SafariServices
import AuthenticationServices

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
    
    @IBOutlet weak var linkButton: UIButton!
    @IBOutlet weak var nameButton: UIButton!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    
    @IBAction func nameButtonTapped(_ sender: Any) {
        Haptics.shared.impact(for: .medium)
    }
    
    var currentCellIndex = 0
    
    let gradient = CAGradientLayer()
    var gradientSet = [[CGColor]]()
    var currentGradient: Int = 0
    var name = ""
    let shape = CAShapeLayer()
    let hour = Calendar.current.component(.hour, from: Date())
    
    
    let gradientOne = UIColor.systemTeal.cgColor
    let gradientTwo = UIColor.systemPurple.cgColor
    let gradientThree = UIColor.systemIndigo.cgColor
    let gradientChangeAnimation = CABasicAnimation(keyPath: "colors")
    
    
    @IBAction func linkButton(_ sender: UIButton) {
        Haptics.shared.vibrate(for: .success)
        UIApplication.shared.open(URL(string: "https://www.quantamagazine.org/what-is-the-geometry-of-the-universe-20200316/")! as URL, options: [:], completionHandler: nil)
    }
    
    
    var arrProductPhotos = [UIImage(named: "home-banner-1")!,
                            UIImage(named: "home-banner-2")!,
                            UIImage(named: "home-banner-3")!,
                            UIImage(named: "home-banner-4")!]

    var timer : Timer?
    
    
    // MARK: - viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
//        let x2 = (UserDefaults.standard.string(forKey: "s1") ?? "Hello") as String
        self.nameButton.setTitle("View", for: self.nameButton.state)
        self.nameButton.showsMenuAsPrimaryAction = true
        self.nameButton.menu = self.addMenuItems()

    }
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var stack: UIView!
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        switch hour {
            case 3...11 : goodLabel.text = "Good Morning"
            case 12...15 : goodLabel.text = "Good Afternoon"
            case 16..<24 : goodLabel.text = "Good Evening"
            default: goodLabel.text = "Hello"
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = arrProductPhotos.count
        
        topView.layer.shadowColor = UIColor.black.cgColor
        topView.layer.shadowOpacity = 1
        topView.layer.shadowOffset = .zero
        topView.layer.shadowRadius = 1
              
        gradientSet.append([gradientOne, gradientTwo])
        gradientSet.append([gradientTwo, gradientThree])
        gradientSet.append([gradientThree, gradientOne])
        animateGradient()
        Haptics.shared.vibrate(for: .success)
    }
    
    // MARK: - viewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        timer?.invalidate()
        startTimer(time: 10)
        
        gradient.removeAnimation(forKey: "colorChange")
        gradient.removeAllAnimations()
        gradient.add(gradientChangeAnimation, forKey: "colorChange")
    }
    
    
    // MARK: - viewDidLayoutSubviews
    override func viewDidLayoutSubviews() {
        
        let childView = UIHostingController(rootView: GradientView())
        addChild(childView)
        childView.view.frame = mainView.bounds
        
        mainView.addSubview(childView.view)
        mainView.bringSubviewToFront(stack)
        mainView.bringSubviewToFront(linkButton)
    
        nameButton.layer.cornerRadius = nameButton.bounds.height / 2

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
    
    func addMenuItems() -> UIMenu {
        
        let menuItems = UIMenu(title: "", options: .displayInline, children: [
            
//            UIAction(title: "Logout", image: UIImage(systemName: "person.crop.circle.fill.badge.minus"), attributes: .destructive, handler: { (_) in
//                Haptics.shared.vibrate(for: .success)
//                KeychainItem.deleteUserIdentifierFromKeychain()
//                DispatchQueue.main.async {
//                        self.showLoginViewController()
//                }
//            }),
            
            UIAction(title: "About the Image", image: UIImage(systemName: "info.circle.fill"), handler: { (_) in
                Haptics.shared.vibrate(for: .success)
                
                var urlString: String?
                
                switch self.currentCellIndex {
                case 0:
                    urlString = "https://esahubble.org/images/heic1808a/"
                case 1:
                    urlString = "https://esahubble.org/images/heic1608a/"
                case 2:
                    urlString = "https://esahubble.org/images/heic0206c/"
                case 3:
                    urlString = "https://esahubble.org/images/heic0601a/"
                default:
                    break
                }
                
                if let urlString = urlString, let url = URL(string: urlString) {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController, animated: true, completion: nil)
                }
            }),
            
            UIAction(title: "What is a Nebula?", image: UIImage(systemName: "cloud.fog.fill"), handler: { (_) in
                Haptics.shared.vibrate(for: .success)
                
                var urlString: String?
                urlString = "https://www.space.com/nebula-definition-types"
                
                if let urlString = urlString, let url = URL(string: urlString) {
                    let safariViewController = SFSafariViewController(url: url)
                    self.present(safariViewController, animated: true, completion: nil)
                }
            }),
            
            
            
//            UIAction(title: "Privacy Policy", image: UIImage(systemName: "book.closed.fill"), handler: { (_) in
//                Haptics.shared.vibrate(for: .success)
//                
//            }),
            
            
        
        ])
        return menuItems
    }
    
    func animateGradient() {
        switch (currentGradient) {
            case 0: currentGradient = 1
            case 1: currentGradient = 2
            case 2: currentGradient = 0
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
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//        let currentTime = Date()
//        let formattedTime = dateFormatter.string(from: currentTime)
//        print("Move time: \(formattedTime)")
        
        
        if (currentCellIndex < arrProductPhotos.count - 1) {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentCellIndex
        
        
        switch (currentCellIndex) {
                
            case 0: label2.text = "Capture by Hubble Space Telescope"
            case 1: label2.text = "Capture by Hubble Space Telescope"
            case 2: label2.text = "Capture by Hubble Space Telescope"
            default: label2.text = "Captured by Hubble Space Telescope"
        }
        
        switch (currentCellIndex) {
            case 0: label3.text = "The Lagoon Nebula"
            case 1: label3.text = "The Bubble Nebula"
            case 2: label3.text = "The Cone Nebula"
            case 3: label3.text = "The Orion Nebula"
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
                
            case 0: label2.text = "Captured by Hubble Space Telescope"
            case 1: label2.text = "Captured by Hubble Space Telescope"
            case 2: label2.text = "Captured by Hubble Space Telescope"
            default: label2.text = "Captured by Hubble Space Telescope"
        }
        
        switch (currentCellIndex) {
            case 0: label3.text = "The Lagoon Nebula"
            case 1: label3.text = "The Bubble Nebula"
            case 2: label3.text = "The Cone Nebula"
            case 3: label3.text = "The Orion Nebula"
            default: label3.text = ""
        }
        
        pageControl.currentPage = currentCellIndex
        timer?.invalidate()
        startTimer(time: 6.0)
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        Haptics.shared.impact(for: .soft)
        timer?.invalidate()
    }
    
    // MARK: - viewDidDisappear
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        gradient.removeAnimation(forKey: "colorChange")
        
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

