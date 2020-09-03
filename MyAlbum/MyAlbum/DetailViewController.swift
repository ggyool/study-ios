//
//  DetailViewController.swift
//  MyAlbum
//
//  Created by ggyool on 2020/09/03.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit
import Photos

class DetailViewController: UIViewController, UIScrollViewDelegate, PHPhotoLibraryChangeObserver {
    
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    var activityButton: UIBarButtonItem!
    var favoriteButton: UIBarButtonItem!
    var trashButton: UIBarButtonItem!
    
    var imageManager: PHCachingImageManager = PHCachingImageManager()
    var asset: PHAsset!
    var assetImage: UIImage?
    
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm:ss"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initToolBar()
        loadImage()
        PHPhotoLibrary.shared().register(self)
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    
    func initNavigationBar() {
        navigationItem.titleView = self.stackView
        loadCreationDate()
    }
    
    func loadCreationDate() {
        guard let creationDate: Date = asset.creationDate else {
            return
        }
        self.dateLabel.text = dateFormatter.string(from: creationDate)
        self.timeLabel.text = timeFormatter.string(from: creationDate)
    }
    
    func initToolBar() {
        activityButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(touchUpActivityButton(_:)))
        favoriteButton = UIBarButtonItem(title: "🖤", style: .plain, target: self, action: #selector(touchUpFavoriteButton(_:)))
        loadFavorite()
        trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(touchUpTrashButton(_:)))
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbarItems = [activityButton, flexibleSpace, favoriteButton, flexibleSpace, trashButton]
    }
    
    func loadFavorite() {
        let favoriteTitle: String = self.asset.isFavorite ? "❤️" : "🖤"
        self.favoriteButton.title = favoriteTitle
    }
    
    func loadImage() {
        imageManager.requestImage(for: asset,
                                  targetSize: CGSize(width: self.imageView.bounds.width, height: self.imageView.bounds.height),
                                  contentMode: .aspectFill,
                                  options: nil,
                                  resultHandler: { image, _ in
                                    // 비동기적이게 하려면 어떻게 하는건지? 이미 비동기인지?
                                    self.imageView.image = image
        })
    }
    
    func refreshPage() {
        loadCreationDate()
        loadFavorite()
    }
    
    @objc func touchUpActivityButton(_ sender: UIBarButtonItem) {
        // 다시 로드해야 하지 않을까
//        let imageToShare: UIImage = UIImage(named: "iphone")!
//
//        let activityViewController = UIActivityViewController(activityItems: [imageToShare], applicationActivities: nil)
//
//        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
//            if success {
//            print("seccess")
//           }  else  {
//            print("fail")
//           }
//        }
//        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func touchUpFavoriteButton(_ sender: UIBarButtonItem) {
        PHPhotoLibrary.shared().performChanges({
            let request = PHAssetChangeRequest(for: self.asset)
            request.isFavorite = !self.asset.isFavorite
        })
    }
    
    @objc func touchUpTrashButton(_ sender: UIBarButtonItem) {
        guard let asset = self.asset else {
            return
        }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets([asset] as NSArray)
        })
    }
    
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: self.asset) else {
            return
        }
        if changes.objectWasDeleted{
            OperationQueue.main.addOperation {
                self.navigationController?.popViewController(animated: true)
            }
            return
        }
        self.asset = changes.objectAfterChanges
        OperationQueue.main.addOperation {
            self.refreshPage()
        }
    }
    
}
