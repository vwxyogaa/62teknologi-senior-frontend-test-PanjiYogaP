//
//  DetailBusinessViewController.swift
//  BusinessEnamDua
//
//  Created by yxgg on 21/05/23.
//

import UIKit
import RxSwift

class DetailBusinessViewController: UIViewController {
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet weak var photoCollectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var reviewCollectionViewHeight: NSLayoutConstraint!
    
    private let disposeBag = DisposeBag()
    var viewModel: DetailBusinessViewModel!
    var id: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        initObserver()
        configureData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        photoCollectionViewHeight.constant = photoCollectionView.frame.height
        reviewCollectionViewHeight.constant = reviewCollectionView.frame.height
    }
    
    private func configureCollectionView() {
        photoCollectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PhotoCollectionViewCell")
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.decelerationRate = .fast
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.photoCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                                  at: .centeredHorizontally,
                                                  animated: true)
        }
        
        reviewCollectionView.register(UINib(nibName: "ReviewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ReviewCollectionViewCell")
        reviewCollectionView.dataSource = self
        reviewCollectionView.delegate = self
    }
    
    private func initObserver() {
        viewModel.isLoading.drive(onNext: { [weak self] isLoading in
            self?.manageLoadingActivity(isLoading: isLoading)
        }).disposed(by: disposeBag)
        
        viewModel.business.drive(onNext: { [weak self] business in
            self?.configureContent(business: business)
        }).disposed(by: disposeBag)
        
        viewModel.photosBusiness.drive(onNext: { [weak self] _ in
            self?.photoCollectionView.reloadData()
        }).disposed(by: disposeBag)
        
        viewModel.reviews.drive(onNext: { [weak self] _ in
            self?.reviewCollectionView.reloadData()
        }).disposed(by: disposeBag)
    }
    
    private func configureData() {
        if let id = id {
            viewModel.getPhotoBusiness(id: id)
            viewModel.getBusinessById(id: id)
            viewModel.getReviewsById(id: id)
        }
    }
    
    private func configureContent(business: Business.BusinessElement?) {
        nameLabel.text = business?.name
        ratingLabel.text = "\(business?.rating ?? 0)⭐️"
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
extension DetailBusinessViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case photoCollectionView:
            return viewModel.photosBusinessCount
        case reviewCollectionView:
            return viewModel.reviewsCount
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case photoCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCollectionViewCell", for: indexPath) as? PhotoCollectionViewCell else { return UICollectionViewCell() }
            let photosBusiness = viewModel.photosBusiness(at: indexPath.row)
            cell.configureContent(photo: photosBusiness)
            return cell
        case reviewCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ReviewCollectionViewCell", for: indexPath) as? ReviewCollectionViewCell else { return UICollectionViewCell() }
            let reviews = viewModel.review(at: indexPath.row)
            cell.configureContent(review: reviews)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case photoCollectionView:
            let photosImage = viewModel.photosBusiness(at: indexPath.row)
            guard let photosImage else { return }
            let vc = ReusableItemDetailImageViewController(nibName: "ReusableItemDetailImageViewController", bundle: nil)
            vc.selectedImageUrl = photosImage
            vc.itemImageUrl = [photosImage]
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case photoCollectionView:
            let width = photoCollectionView.frame.width * 0.9
            let height = photoCollectionView.frame.height
            return CGSize(width: width, height: height)
        case reviewCollectionView:
            let width = 358
            let height = 118
            return CGSize(width: width, height: height)
        default:
            return CGSize(width: 0, height: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        switch collectionView {
        case photoCollectionView:
            return 8
        case reviewCollectionView:
            return 8
        default:
            return 0
        }
    }
}
