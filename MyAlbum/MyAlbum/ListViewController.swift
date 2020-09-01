//
//  ListViewController.swift
//  MyAlbum
//
//  Created by ggyool on 2020/09/01.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit
import Photos

class ListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PHPhotoLibraryChangeObserver {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var toolBar: ListToolBar!
    
    let cellIdentifier: String = "cell"
    let imageManager: PHCachingImageManager = PHCachingImageManager()

    var collection: PHAssetCollection?
    var fetchResult: PHFetchResult<PHAsset>!
    var selectButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initCollectionView()
        initNavaigationBar()
        initToolBar()
        requestAsset()
        PHPhotoLibrary.shared().register(self)
    }
    
    func initCollectionView() {
        let criteria: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)
        let distance: CGFloat = criteria/60
        let flowLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = distance // 최소 item 간 거리
        flowLayout.minimumLineSpacing = distance // 줄 간의 최소 거리
        flowLayout.itemSize = CGSize(width: (criteria-2*distance)/3, height: (criteria-2*distance)/3)
        collectionView.collectionViewLayout = flowLayout
        
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = false
    }
    
    func initNavaigationBar() {
        self.navigationItem.title = self.collection?.localizedTitle
        selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.touchUpSelectButton(_:)))
        cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.touchUpCancelButton(_:)))
        self.navigationItem.rightBarButtonItem = selectButton
    }
    
    func initToolBar() {
        disableBarButton(toolBar.activityButton)
        enableBarButton(toolBar.orderStateButton)
        disableBarButton(toolBar.trashButton)
    }
    
    func disableBarButton(_ button: UIBarButtonItem) {
        button.tintColor = .lightGray
        button.isEnabled = false
    }
    
    func enableBarButton(_ button: UIBarButtonItem) {
        // default tint color 알아낼 방법이 있는지?
        button.tintColor = toolBar.orderStateButton.tintColor
        button.isEnabled = true
    }
    
    @objc func touchUpSelectButton(_ sender: UIBarButtonItem) {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "항목 선택"
        self.navigationItem.rightBarButtonItem = cancelButton
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        enableBarButton(toolBar.activityButton)
        enableBarButton(toolBar.trashButton)
    }
    
    @objc func touchUpCancelButton(_ sender: UIBarButtonItem) {
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title = self.collection?.localizedTitle
        self.navigationItem.rightBarButtonItem = selectButton
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = false
        disableBarButton(toolBar.activityButton)
        disableBarButton(toolBar.trashButton)
    }

    
    func requestAsset() {
        if collection?.localizedTitle == "Recents" {
            fetchResult = PHAsset.fetchAssets(in: collection!, options: nil)
        }
        else {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
            fetchResult = PHAsset.fetchAssets(in: collection!, options: fetchOptions)
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return fetchResult.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: ListCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as? ListCollectionViewCell else {
                assertionFailure("error")
                return UICollectionViewCell()
        }
        
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        let asset: PHAsset = fetchResult.object(at: indexPath.item)
        imageManager.requestImage(for: asset,
                                   targetSize: CGSize(width: cell.thumbnailImageView.bounds.width, height: cell.thumbnailImageView.bounds.height),
                                  contentMode: .aspectFill,
                                  options: options,
                                  resultHandler: {image, _ in
                                    cell.thumbnailImageView.image = image
        })
        return cell
    }
    

    // UICollectionViewDelegate methods
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.allowsSelection && collectionView.allowsMultipleSelection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select " + "\(indexPath.item)")
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        print("deSelect " + "\(indexPath.item)")
        return false
        
    }
    
    // PHPhotoLibraryChangeObserver methods
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        
    }
}
