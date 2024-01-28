
//  ========================================
//  UranusViewController.swift
//  Cosmofy
//  4th Edition
//  Created by Arryan Bhatnagar on 1/14/24.
//  ========================================

import UIKit
import TipKit

class UranusViewController: UIViewController,
                             UICollectionViewDelegate,
                             UICollectionViewDataSource,
                             UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    
    @IBOutlet weak var coreLabel1: UILabel!
    @IBOutlet weak var coreLabel2: UILabel!
    @IBOutlet weak var cuteImage: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var imageCaption: UILabel!
    
    @IBAction func buttons_tapped(_ sender: Any) {
        Haptics.shared.impact(for: .medium)
    }
    
    var arrayPhotos =
    [
        UIImage(named: "20240114_Uranus_1")!,
        UIImage(named: "20240114_Uranus_2")!,
        UIImage(named: "20240114_Uranus_3")!
    ]
     
    var timer1 : Timer? // text
    var timer2 : Timer? // pulse
    var timer3 : Timer? // images
    var currentLabel = 1
    var currentCellIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 17.0, *) {
            Task { @MainActor in
                for await shouldDisplay in modelTip.shouldDisplayUpdates {
                    if shouldDisplay {
                        let controller = TipUIPopoverViewController(modelTip, sourceItem: button1)
                        present(controller, animated: true)
                    } else if presentedViewController is TipUIPopoverViewController {
                        dismiss(animated: true)
                        
                    }
                }
            }
        }
        collectionView.delegate = self
        collectionView.dataSource = self
        pageControl.numberOfPages = arrayPhotos.count
        
        startTimer1()
        startTimer2()
        startTimer3()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    func startTimer1() {
        timer1 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    func startTimer2() {
        timer2 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(self.addPulse), userInfo: nil, repeats: true)
    }
    
    func startTimer3() {
        timer3 = Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(moveNext), userInfo: nil, repeats: true)
    }
    
    func invalidateTimers() {
        timer1?.invalidate()
        timer2?.invalidate()
        timer3?.invalidate()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentCellIndex = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentCellIndex
        invalidateTimers()
        startTimer1()
        startTimer2()
        startTimer3()
        
        if (currentCellIndex == 2) {
            imageCaption.text = ""
        } else {
            imageCaption.text = ""
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        Haptics.shared.impact(for: .soft)
    }
    
    @objc func moveNext() {
        
        if (currentCellIndex < arrayPhotos.count - 1) {
            currentCellIndex += 1
        } else {
            currentCellIndex = 0
        }
        
        collectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        
        pageControl.currentPage = currentCellIndex
        Haptics.shared.impact(for: .soft)
        if (currentCellIndex == 2) {
            imageCaption.text = ""
        } else {
            imageCaption.text = ""
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrayPhotos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "uranusCell", for: indexPath) as! UranusCell
        cell.image.image = arrayPhotos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    @objc func addPulse () {
        let newTap1 = view1.convert(button1.center, to: view)
        let newTap2 = view1.convert(button2.center, to: view)
        let newTap5 = view1.convert(cuteImage.center, to: view)
        
        let pulse1 = Pulse(num: 1, rad: 32, pos: newTap1, duration: 1)
        let pulse2 = Pulse(num: 1, rad: 32, pos: newTap2, duration: 1)
        let pulse5 = Pulse(num: 1, rad: 32, pos: newTap5, duration: 1)
        
        pulse1.backgroundColor = UIColor(named: "colorUranus")?.cgColor
        pulse2.backgroundColor = UIColor(named: "colorUranus")?.cgColor
        pulse5.backgroundColor = UIColor(named: "colorUranus")?.cgColor
        
        self.view.layer.insertSublayer(pulse1, below: button1.layer)
        self.view.layer.insertSublayer(pulse2, below: button2.layer)
        self.view.layer.insertSublayer(pulse5, below: cuteImage.layer)
    }
    
    override func viewDidLayoutSubviews() {
        
        view1.layer.shadowColor = UIColor.black.cgColor
        view1.layer.shadowOpacity = 1
        view1.layer.shadowOffset = .zero
        view1.layer.shadowRadius = 1
        view1.layer.cornerRadius = 24
        view1.layer.borderColor = UIColor.black.cgColor
        view1.layer.borderWidth = 1
        
        view2.layer.shadowColor = UIColor.black.cgColor
        view2.layer.shadowOpacity = 1
        view2.layer.shadowOffset = .zero
        view2.layer.shadowRadius = 1
        view2.layer.cornerRadius = 24
        view2.layer.borderColor = UIColor.black.cgColor
        view2.layer.borderWidth = 1
        
        view3.layer.shadowColor = UIColor.black.cgColor
        view3.layer.shadowOpacity = 1
        view3.layer.shadowOffset = .zero
        view3.layer.shadowRadius = 1
        view3.layer.cornerRadius = 24
        view3.layer.borderColor = UIColor.black.cgColor
        view3.layer.borderWidth = 1
        
        button1.layer.shadowColor = UIColor.white.cgColor
        button1.layer.shadowOpacity = 1
        button1.layer.shadowOffset = .zero
        button1.layer.shadowRadius = 1
        button1.layer.cornerRadius = button1.frame.height / 2
        button1.clipsToBounds = true
        button1.layer.borderColor = UIColor.black.cgColor
        button1.layer.borderWidth = 2
        
        button2.layer.shadowColor = UIColor.white.cgColor
        button2.layer.shadowOpacity = 1
        button2.layer.shadowOffset = .zero
        button2.layer.shadowRadius = 1
        button2.layer.cornerRadius = button2.frame.height / 2
        button2.clipsToBounds = true
        button2.layer.borderColor = UIColor.black.cgColor
        button2.layer.borderWidth = 2
        

    }
    
    override func viewDidDisappear(_ animated: Bool) {
        invalidateTimers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent {
            Haptics.shared.impact(for: .soft)
        }
    }
    
    @objc func moveToNextIndex() {
        
        if (currentLabel == 0) {
            
            UIView.transition(with: coreLabel1,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel1.text = "William Herschel"
                     }, completion: nil)
            
            UIView.transition(with: coreLabel2,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel2.text = "Discovered Uranus in 1781"
                     }, completion: nil)
            currentLabel = currentLabel + 1
        } else if (currentLabel == 1) {
            
            
            UIView.transition(with: coreLabel1,
                          duration: 0.25,
                              options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel1.text = "Uranus is surrounded"
                     }, completion: nil)
            
            UIView.transition(with: coreLabel2,
                          duration: 0.25,
                              options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel2.text = "by faint rings"
                     }, completion: nil)
            currentLabel = currentLabel + 1
        } else if (currentLabel == 2) {
            currentLabel = 0
            
            UIView.transition(with: coreLabel1,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel1.text = "Uranus rotates at"
                     }, completion: nil)
            
            UIView.transition(with: coreLabel2,
                          duration: 0.25,
                           options: .transitionCrossDissolve,
                        animations: { [weak self] in
                self?.coreLabel2.text = "nearly 90 degrees"
                     }, completion: nil)
            
        }
        
    }
}


