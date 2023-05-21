//
//  ReusableItemDetailImageViewController.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import UIKit

class ReusableItemDetailImageViewController: UIViewController {
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var itemImageView: UIImageView!
    
    var selectedImageUrl = ""
    var itemImageUrl: [String] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupGesture()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Helpers
    private func setupView() {
        imageScrollView.delegate = self
        imageScrollView.flashScrollIndicators()
        imageScrollView.minimumZoomScale = 1.0
        imageScrollView.maximumZoomScale = 4.0
        itemImageView.clipsToBounds = false
        backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
    }
    
    private func setupGesture() {
        let doubleTapGest = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapScrollView(recognizer:)))
        doubleTapGest.numberOfTapsRequired = 2
        imageScrollView.addGestureRecognizer(doubleTapGest)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    private func setupData() {
        self.itemImageView.kf.setImage(with: URL(string: selectedImageUrl), placeholder: UIImage.init(named: "logo-kf-small-blue"), options: [.transition(.fade(0))], progressBlock: nil) { result in
            switch result {
            case .success(let value):
                self.itemImageView.image = value.image
            case .failure:
                self.itemImageView.image = UIImage(named: "logo-kf-small-blue")
            }
        }
    }
    
    private func nextImage() {
        let currentIndex = itemImageUrl.firstIndex(of: selectedImageUrl) ?? -1
        var nextIndex = currentIndex + 1
        nextIndex = itemImageUrl.indices.contains(nextIndex) ? nextIndex : 0
        selectedImageUrl = itemImageUrl[nextIndex]
        setupData()
    }
    
    private func prevImage() {
        let currentIndex = itemImageUrl.firstIndex(of: selectedImageUrl) ?? -1
        var prevIndex = currentIndex - 1
        prevIndex = itemImageUrl.indices.contains(prevIndex) ? prevIndex : itemImageUrl.count - 1
        selectedImageUrl = itemImageUrl[prevIndex]
        setupData()
    }
    
    // MARK: Actions
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func handleDoubleTapScrollView(recognizer: UITapGestureRecognizer) {
        if imageScrollView.zoomScale == 1 {
            imageScrollView.zoom(to: zoomRectForScale(scale: 4.0, center: recognizer.location(in: recognizer.view)), animated: true)
        } else {
            imageScrollView.setZoomScale(1, animated: true)
        }
    }
    
    @objc
    private func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizer.Direction.right:
                if imageScrollView.zoomScale == 1.0 {
                    print("Swiped right")
                    nextImage()
                } else {
                    print("Not swipe but geser")
                }
            case UISwipeGestureRecognizer.Direction.down:
                print("Swiped down")
            case UISwipeGestureRecognizer.Direction.left:
                if imageScrollView.zoomScale == 1.0 {
                    print("Swiped left")
                    prevImage()
                } else {
                    print("Not swipe but geser")
                }
            case UISwipeGestureRecognizer.Direction.up:
                print("Swiped up")
            default:
                break
            }
        }
    }
    
    // MARK: Zoom
    func zoomRectForScale(scale: CGFloat, center: CGPoint) -> CGRect {
        var zoomRect = CGRect.zero
        zoomRect.size.height = itemImageView.frame.size.height / scale
        zoomRect.size.width  = itemImageView.frame.size.width  / scale
        let newCenter = itemImageView.convert(center, from: imageScrollView)
        zoomRect.origin.x = newCenter.x - (zoomRect.size.width / 2.0)
        zoomRect.origin.y = newCenter.y - (zoomRect.size.height / 2.0)
        return zoomRect
    }
}

// MARK: - UIScrollViewDelegate
extension ReusableItemDetailImageViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.itemImageView
    }
}
