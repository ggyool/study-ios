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
    @IBOutlet weak var activityButton: UIBarButtonItem!
    @IBOutlet weak var orderStateButton: UIBarButtonItem!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    var selectButton: UIBarButtonItem!
    var cancelButton: UIBarButtonItem!
    
    let cellIdentifier: String = "cell"
    let imageManager: PHCachingImageManager = PHCachingImageManager()

    var collection: PHAssetCollection?
    var fetchResult: PHFetchResult<PHAsset>!
    var orderState: OrderState = .forward {
        didSet {
            self.orderStateButton.title = self.orderState.rawValue
        }
    }
    
    enum OrderState: String {
        case forward = "최신순"
        case reverse = "과거순"
        func getToggle() -> OrderState {
            if self == .forward {
                return .reverse
            } else{
                return .forward
            }
        }
    }
    
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
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func initToolBar() {
        disableBarButton(self.activityButton)
        enableBarButton(self.orderStateButton)
        disableBarButton(self.trashButton)
    }
    
    func disableBarButton(_ button: UIBarButtonItem) {
        button.tintColor = .lightGray
        button.isEnabled = false
    }
    
    func enableBarButton(_ button: UIBarButtonItem) {
        // default tint color 알아낼 방법이 있는지?
        button.tintColor = self.selectButton.tintColor
        button.isEnabled = true
    }
    
    @objc func touchUpSelectButton(_ sender: UIBarButtonItem) {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "항목 선택"
        self.navigationItem.rightBarButtonItem = cancelButton
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        enableBarButton(self.orderStateButton)
        disableBarButton(self.orderStateButton)
    }
    
    @objc func touchUpCancelButton(_ sender: UIBarButtonItem) {
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title = self.collection?.localizedTitle
        self.navigationItem.rightBarButtonItem = selectButton
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = false
        disableBarButton(self.activityButton)
        enableBarButton(self.orderStateButton)
        disableBarButton(self.trashButton)
    }

    
    func requestAsset() {
        if collection?.localizedTitle == "Recents" {
            fetchResult = PHAsset.fetchAssets(in: collection!, options: nil)
            // Recents 는 firstObject가 과거
            self.orderState = .reverse
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
                assert(false)
        }
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        let asset: PHAsset =
        self.orderState == .forward ?
            fetchResult.object(at: indexPath.item) :
            fetchResult.object(at: fetchResult.count-indexPath.item-1)
            
        
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
    
    func collectionView(_ collectionView: UICollectionView, shouldDeselectItemAt indexPath: IndexPath) -> Bool {
        return collectionView.allowsSelection && collectionView.allowsMultipleSelection
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.collectionView.indexPathsForSelectedItems?.count == 1 {
            enableBarButton(self.activityButton)
            enableBarButton(self.trashButton)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if self.collectionView.indexPathsForSelectedItems?.count == 0 {
            disableBarButton(self.activityButton)
            disableBarButton(self.trashButton)
        }
    }
    
    
    
    @IBAction func touchUpOrderStateButton(_ sender: Any) {
        self.orderState = self.orderState.getToggle()
        self.collectionView.reloadSections(IndexSet(0...0))
    }
    
    
    var deleteFlag: Bool = false
    @IBAction func touchUpTrashButton(_ sender: UIBarButtonItem) {
        guard let indexPaths: [IndexPath] = collectionView.indexPathsForSelectedItems else {
            assert(false)
        }
        var deleteTarget: [PHAsset] = []
        for indexPath in indexPaths {
            let asset: PHAsset = self.fetchResult[indexPath.item]
            deleteTarget.append(asset)
        }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(deleteTarget as NSArray)
            self.deleteFlag = true
        })
     }


    // PHPhotoLibraryChangeObserver methods
    // 가끔 2번 호출 되는 경우가 있다. 이유는 잘.. 부분적으로 지워지는것 같지는 않음
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        fetchResult = changes.fetchResultAfterChanges
        OperationQueue.main.addOperation {
            guard let indexPaths: [IndexPath] = self.collectionView.indexPathsForSelectedItems else {
                assert(false)
            }
            // 지운 경우에는 지운 행만 삭제하고, 외부에서 이미지가 추가 된경우 새로고침 한다.
            if self.deleteFlag {
                self.collectionView.performBatchUpdates({
                self.collectionView.deleteItems(at: indexPaths)
                }, completion: { _ in
                    self.deleteFlag = false
                })
            }
            else {
                self.collectionView.reloadSections(IndexSet(0...0))
            }
        }
    }
}


