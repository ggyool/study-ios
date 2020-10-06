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
    
    
    var selectMode: Bool = false
    
    var orderState: OrderState = .forward {
        didSet {
            self.orderStateButton.title = self.orderState.rawValue
        }
    }
    
    enum OrderState: String {
        case forward = "과거순"
        case reverse = "최신순"
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
        let miniumItemCountInLine: CGFloat = 3.0
        let spacingCount: CGFloat = miniumItemCountInLine - 1.0
        let edgeSpacing: CGFloat = 0
        let itemSpacing: CGFloat = criteria/60
        let flowLayout: UICollectionViewFlowLayout =  UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero
        flowLayout.minimumInteritemSpacing = itemSpacing-1 // 최소 item 간 거리
        flowLayout.minimumLineSpacing = itemSpacing // 줄 간의 최소 거리
        let cellWidth: CGFloat = (criteria-itemSpacing*spacingCount-2*edgeSpacing)/miniumItemCountInLine
        let cellHeight: CGFloat = cellWidth
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.collectionViewLayout = flowLayout
    
        self.selectMode = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
    }
    
    func initNavaigationBar() {
        self.navigationItem.title = self.collection?.localizedTitle
        selectButton = UIBarButtonItem(title: "선택", style: .plain, target: self, action: #selector(self.touchUpSelectButton(_:)))
        cancelButton = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(self.touchUpCancelButton(_:)))
        self.navigationItem.rightBarButtonItem = selectButton
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    func initToolBar() {
        disableBarButton(self.activityButton)
        enableBarButton(self.orderStateButton)
        disableBarButton(self.trashButton)
        navigationController?.setToolbarHidden(false, animated: false)
    }
    
    func disableBarButton(_ button: UIBarButtonItem) {
        button.tintColor = .lightGray
        button.isEnabled = false
    }
    
    func enableBarButton(_ button: UIBarButtonItem) {
        button.tintColor = self.selectButton.tintColor
        button.isEnabled = true
    }
    
    @objc func touchUpSelectButton(_ sender: UIBarButtonItem) {
        self.navigationItem.hidesBackButton = true
        self.navigationItem.title = "항목 선택"
        self.navigationItem.rightBarButtonItem = cancelButton
        
        self.selectMode = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        enableBarButton(self.activityButton)
        disableBarButton(self.orderStateButton)
        enableBarButton(self.trashButton)
    }
    
    @objc func touchUpCancelButton(_ sender: UIBarButtonItem) {
        self.navigationItem.hidesBackButton = false
        self.navigationItem.title = self.collection?.localizedTitle
        self.navigationItem.rightBarButtonItem = selectButton
        
        self.selectMode = false
        // 모두 deselect 해야 하는 상황인데 false로 바꾸면 모두 해제 되길래 이렇게 함
        collectionView.allowsSelection = false
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = true
        disableBarButton(self.activityButton)
        enableBarButton(self.orderStateButton)
        disableBarButton(self.trashButton)
    }

    
    func requestAsset() {
        // 모든 result는 과거순으로 불w러옴
        if collection?.localizedTitle == "Recents" {
            fetchResult = PHAsset.fetchAssets(in: collection!, options: nil)
        }
        else {
            let fetchOptions = PHFetchOptions()
            fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
            fetchResult = PHAsset.fetchAssets(in: collection!, options: fetchOptions)
            self.orderState = .reverse
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
        cell.layer.borderColor = CGColor(srgbRed: 0.8, green: 0.8, blue: 1, alpha: 0.9)
        // cell reuse
        if self.collectionView.indexPathsForSelectedItems?.contains(indexPath) ?? false {
            cell.isSelected = true
            cell.layer.borderWidth = 5
        }
        else {
            cell.isSelected = false
            cell.layer.borderWidth = 0
        }

        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        let idx: Int = self.getAssetIndex(indexPath.item)
        let asset: PHAsset = fetchResult.object(at: idx)
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
        // 선택모드가 아니면 창 전환
        if !self.selectMode {
            let nextViewController = self.storyboard!.instantiateViewController(identifier: "detailViewController") as DetailViewController
            let idx: Int = self.getAssetIndex(indexPath.item)
            nextViewController.asset = self.fetchResult[idx]
            self.navigationController?.pushViewController(nextViewController, animated: true)
            return
        }
        
        // title text
        if let selectedCount: Int = self.collectionView.indexPathsForSelectedItems?.count {
            if selectedCount == 0{
                self.navigationItem.title = "항목 선택"
            } else {
                self.navigationItem.title = "\(selectedCount)장 선택"
            }
        }
        // 선택에 따른 버튼 활성화
        if self.collectionView.indexPathsForSelectedItems?.count == 1 {
            enableBarButton(self.activityButton)
            enableBarButton(self.trashButton)
        }
        // 선택 셀 테두리 설정
        if let cell: ListCollectionViewCell = self.collectionView.cellForItem(at: indexPath) as? ListCollectionViewCell {
            cell.layer.borderWidth = 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if !self.selectMode {
            return
        }
        // 타이틀 설정
        if let selectedCount: Int = self.collectionView.indexPathsForSelectedItems?.count {
            if selectedCount == 0{
                self.navigationItem.title = "항목 선택"
            } else {
                self.navigationItem.title = "\(selectedCount)장 선택"
            }
        }
        // 선택에 따른 버튼 비활성화
        if self.collectionView.indexPathsForSelectedItems?.count == 0 {
            disableBarButton(self.activityButton)
            disableBarButton(self.trashButton)
        }
        if let cell: ListCollectionViewCell = self.collectionView.cellForItem(at: indexPath) as? ListCollectionViewCell {
            cell.layer.borderWidth = 0
        }
    }
    
    @IBAction func touchUpActivityButton(_ sender: Any) {
        guard let indexPaths: [IndexPath] = self.collectionView.indexPathsForSelectedItems else {
            assert(false)
        }
        var selectedImages: [UIImage] = []
        for indexPath in indexPaths {
            let idx: Int = self.getAssetIndex(indexPath.item)
            let asset: PHAsset = self.fetchResult[idx]
            
            // 원본 이미지 가져오기
            let options = PHImageRequestOptions()
            options.isSynchronous = true
            options.resizeMode = PHImageRequestOptionsResizeMode.none
            imageManager.requestImage(for: asset,
                                      targetSize: PHImageManagerMaximumSize,
                                      contentMode: .aspectFill,
                                      options: options,
                                      resultHandler: {loadedImage, _ in
                                        guard let image = loadedImage else {
                                            return
                                        }
                                        selectedImages.append(image)
            })
        }
        let activityViewController = UIActivityViewController(activityItems: selectedImages, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activity, success, items, error) in
            if success {
                self.touchUpCancelButton(self.cancelButton) // 지우고 탐색모드로 돌아옴
            } else  {
                // fail
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func touchUpOrderStateButton(_ sender: Any) {
        self.orderState = self.orderState.getToggle()
        self.collectionView.reloadSections(IndexSet(0...0))
    }
    
    // .reverse인 경우 fetchResult의 뒤부터 cell로 가져온다.
    func getAssetIndex(_ indexPathItem: Int) -> Int {
        if self.orderState == .forward {
            return indexPathItem
        }
        return self.fetchResult.count - indexPathItem - 1
    }
    
    @IBAction func touchUpTrashButton(_ sender: UIBarButtonItem) {
        guard let indexPaths: [IndexPath] = self.collectionView.indexPathsForSelectedItems else {
            assert(false)
        }
        var deleteTarget: [PHAsset] = []
        for indexPath in indexPaths {
            let idx: Int = self.getAssetIndex(indexPath.item)
            let asset: PHAsset = self.fetchResult[idx]
            deleteTarget.append(asset)
        }
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(deleteTarget as NSArray)
        })
        
     }


    // PHPhotoLibraryChangeObserver methods
    func photoLibraryDidChange(_ changeInstance: PHChange) {
        guard let changes = changeInstance.changeDetails(for: fetchResult) else {
            return
        }
        fetchResult = changes.fetchResultAfterChanges
        OperationQueue.main.addOperation {
            // 변경 사항이 커서 reload 해야할 시 false
            if changes.hasIncrementalChanges {
                self.collectionView.performBatchUpdates({
                    if let removed = changes.removedIndexes, removed.count > 0 {
                        print("remove")
                        self.collectionView.deleteItems(at: removed.map { IndexPath(item: $0, section:0) })
                    }
                    if let inserted = changes.insertedIndexes, inserted.count > 0 {
                        print("insert")
                        self.collectionView.insertItems(at: inserted.map { IndexPath(item: $0, section:0) })
                    }
                    if let changed = changes.changedIndexes, changed.count > 0 {
                        print("change")
                        self.collectionView.reloadItems(at: changed.map { IndexPath(item: $0, section:0) })
                    }
                }, completion: { _ in
                    self.touchUpCancelButton(self.cancelButton) // 지우고 탐색모드로 돌아옴
                })
                
            }
            else {
                print("reload")
                self.collectionView.reloadSections(IndexSet(0...0))
            }
        }
    }
    
    
}


