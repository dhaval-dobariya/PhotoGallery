//
//  GalleryViewController.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 11/03/22.
//

import UIKit
import SDWebImage

class GalleryViewController: UIViewController {

    //MARK: Variables
    @IBOutlet weak var switchViewTypeButton: UIBarButtonItem!
    @IBOutlet weak var galleryCollectionView: UICollectionView!
    let viewModel = GalleryViewModel()
    
    //MARK: View Controller Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // To Setup UIs
        setupUI()
        
        // To fetch gallery images using API
        viewModel.fetchGallery { [weak self] in
            // To refresh the view once we have the data
            self?.galleryCollectionView.reloadData()
        }
    }
    
    /// To setup UIs for this screen
    private func setupUI() {
        galleryCollectionView.register(UINib(nibName: GalleryItemCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: GalleryItemCollectionViewCell.identifier)
        galleryCollectionView.dataSource = self
        galleryCollectionView.delegate = self
        
//        switchViewTypeButton.isSelected = true
        performViewTypeSelectionChangeOperations()
    }

    //MARK: IBActions
    @IBAction func switchViewType(_ sender: UIBarButtonItem) {
        switchViewTypeButton.isSelected = !switchViewTypeButton.isSelected
        performViewTypeSelectionChangeOperations()
    }
    
    /// To perform actions needed to swift view type between list and grid view
    private func performViewTypeSelectionChangeOperations() {
        if switchViewTypeButton.isSelected {
            switchViewTypeButton.setBackgroundImage(UIImage(named: "show_list_view"), for: .normal, barMetrics: .default)
        } else {
            switchViewTypeButton.setBackgroundImage(UIImage(named: "show_grid_view"), for: .normal, barMetrics: .default)
        }
        galleryCollectionView.reloadData()
    }
    
}

/// UICollectionView DataSource layout methods
extension GalleryViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.photos?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryItemCollectionViewCell.identifier, for: indexPath) as! GalleryItemCollectionViewCell
        
        if let photo = viewModel.photos?[indexPath.item] {
            if let thumnUrl = photo.urls.thumb {
                cell.galleryImage.sd_setImage(with: URL(string: thumnUrl), placeholderImage: UIImage(named: "photo_placeholder"), options: SDWebImageOptions.refreshCached, context: nil)
            } else {
                cell.galleryImage.image = UIImage(named: "photo_placeholder")
            }
            cell.userName.text = photo.user.name
            cell.galleryDescription.text = photo.photoDescription
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        var cellWidth = (collectionView.frame.size.width / 2)
        let cellHeight: CGFloat =  170
        if switchViewTypeButton.isSelected == false {
            cellWidth = collectionView.frame.size.width
        }
        
        var textHeight: CGFloat = 0
        if let photo = viewModel.photos?[indexPath.item], let photoDescription = photo.photoDescription {
            textHeight = Utilities.getTextHeight(width: cellWidth, addExtraHeight: 10, sourceString: photoDescription, font: UIFont.systemFont(ofSize: 17, weight: .light))
        }
        
        if textHeight > 0, switchViewTypeButton.isSelected {
            textHeight = (textHeight > 25 ? 25 : textHeight)
        }
        
        return CGSize(width: cellWidth, height: cellHeight + textHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.1
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? GalleryItemCollectionViewCell else {
            return
        }
        
        let photoDetails = PhotoDetailsViewController()
        photoDetails.photoToZoom = cell.galleryImage.image
        photoDetails.modalPresentationStyle = .overCurrentContext
        self.present(photoDetails, animated: true, completion: nil)
    }
}
