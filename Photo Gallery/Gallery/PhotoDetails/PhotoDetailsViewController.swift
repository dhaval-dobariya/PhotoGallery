//
//  PhotoDetailsViewController.swift
//  Photo Gallery
//
//  Created by Dhaval Dobariya on 13/03/22.
//

import UIKit

class PhotoDetailsViewController: UIViewController {

    //MARK: Variables
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var photoImageView: UIImageView!
    var photoToZoom: UIImage!
    
    //MARK: View Controller Life Cycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // To Setup UIs
        setupUI()
    }
    
    /// To setup UIs for this screen
    private func setupUI() {
        scrollView.minimumZoomScale = 1
        scrollView.maximumZoomScale = 4
        
        photoImageView.image = photoToZoom
    }

    //MARK: IBActions
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

/// UIScrollView Delegate methods
extension PhotoDetailsViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = photoImageView.image {
                let ratioW = photoImageView.frame.width / image.size.width
                let ratioH = photoImageView.frame.height / image.size.height
                
                let ratio = ratioW < ratioH ? ratioW : ratioH
                let newWidth = image.size.width * ratio
                let newHeight = image.size.height * ratio
                let conditionLeft = newWidth*scrollView.zoomScale > photoImageView.frame.width
                let left = 0.5 * (conditionLeft ? newWidth - photoImageView.frame.width : (scrollView.frame.width - scrollView.contentSize.width))
                let conditioTop = newHeight*scrollView.zoomScale > photoImageView.frame.height
                
                let top = 0.5 * (conditioTop ? newHeight - photoImageView.frame.height : (scrollView.frame.height - scrollView.contentSize.height))
                
                scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
                
            }
        } else {
            scrollView.contentInset = .zero
        }
    }
}
