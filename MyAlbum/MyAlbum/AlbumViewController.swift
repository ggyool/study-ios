//
//  ViewController.swift
//  MyAlbum
//
//  Created by ggyool on 2020/08/30.
//  Copyright © 2020 ggyool. All rights reserved.
//

                
import UIKit
import Photos

class AlbumViewController: UIViewController, UICollectionViewDataSource, UIScrollViewDelegate, PHPhotoLibraryChangeObserver {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellIdentifier: String = "cell"
    var collections: [PHAssetCollection] = []
    var imageManager: PHCachingImageManager = PHCachingImageManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initNavigationBar()
        initCollectionView()
        if(authorizePhotoLibrary()){
            requestCollection()
            self.collectionView.reloadSections(IndexSet(0...0))
        }
        PHPhotoLibrary.shared().register(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    func initNavigationBar() {
        navigationController?.setToolbarHidden(true, animated: false)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // large title일 때 separator
        let appearance = UINavigationBarAppearance()
        self.navigationController?.navigationBar.scrollEdgeAppearance = appearance
    }

    func initCollectionView() {
        
        // 나중에 Trait collection 이용하는 방법으로 만들어보자
        let viewWidth: CGFloat = view.bounds.width
        let itemCountPerLine: CGFloat = 2
        let spacingCountPerLine: CGFloat = itemCountPerLine - 1
        let itemSpacing: CGFloat = viewWidth * 0.03
        let edgeMargin: CGFloat = viewWidth * 0.03
        let cellWidth: CGFloat = (viewWidth - itemSpacing * spacingCountPerLine - 2*edgeMargin) / itemCountPerLine
        let cellHeight: CGFloat = 1.4 * cellWidth
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: edgeMargin, left: edgeMargin, bottom: edgeMargin, right: edgeMargin)
        flowLayout.minimumInteritemSpacing = itemSpacing * 0.8
        flowLayout.minimumLineSpacing = itemSpacing
        flowLayout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView.collectionViewLayout = flowLayout
    }

    
    func authorizePhotoLibrary() -> Bool {
        var isAuthorized: Bool = false
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if photoAuthorizationStatus == .authorized {
            isAuthorized = true
        }
        else if photoAuthorizationStatus == .notDetermined {
            PHPhotoLibrary.requestAuthorization({
                (status) in
                if status == .authorized {
                    isAuthorized = true
                }
            })
        }
        return isAuthorized
    }
    
    func requestCollection() {
        let cameraRollResult: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumUserLibrary, options: nil)
        let favoriteResult: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumFavorites, options: nil)
        let albumResult: PHFetchResult<PHAssetCollection> =
            PHAssetCollection.fetchAssetCollections(with: .album, subtype: .any, options: nil)
        self.collections.removeAll()
        if let cameraRoll: PHAssetCollection = cameraRollResult.firstObject {
            self.collections.append(cameraRoll)
        }
        if let favorite: PHAssetCollection = favoriteResult.firstObject {
            self.collections.append(favorite)
        }
        for i in 0..<albumResult.count {
            self.collections.append(albumResult.object(at: i))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.collections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: AlbumCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as? AlbumCollectionViewCell else {
                fatalError()
        }
        let collection: PHAssetCollection = self.collections[indexPath.item]
        let title: String = collection.localizedTitle!
        var fetchOptions: PHFetchOptions? = PHFetchOptions()
        if title == "Recents" {
            fetchOptions = nil
        }
        else {
            // 최신순
            fetchOptions?.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        }
            
        let fetchResult: PHFetchResult<PHAsset> = PHAsset.fetchAssets(in: collection, options: fetchOptions)
        cell.titleLabel.text = collection.localizedTitle
        cell.countLabel.text = String(fetchResult.count)
        
        let options: PHImageRequestOptions = PHImageRequestOptions()
        options.resizeMode = PHImageRequestOptionsResizeMode.exact
        
        // recents, favorites 의 경우 대표이미지로 lastObject를 골라야한다.
        let lastImageCondition: Bool = title == "Recents" || title == "Favorites"
        if let asset: PHAsset = (lastImageCondition ? fetchResult.lastObject : fetchResult.firstObject) {
            imageManager.requestImage(for: asset,
                                      targetSize: CGSize(width: cell.thumbnailImageView.bounds.width, height: cell.thumbnailImageView.bounds.height),
                                      contentMode: .aspectFill,
                                      options: options,
                                      resultHandler: {image, _ in
                                        cell.thumbnailImageView?.image = image
            })
        }
        else {
            cell.thumbnailImageView.image = UIImage(systemName: "photo")
        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let nextViewController: ListViewController = segue.destination as? ListViewController,
            let indexPaths: [IndexPath] = collectionView.indexPathsForSelectedItems else {
                return
        }
        nextViewController.collection = self.collections[indexPaths[0].item]
    }

    func photoLibraryDidChange(_ changeInstance: PHChange) {
        // 어떤 변화가 있을지 모르기 때문에 다시 요청하는게 나을듯
        requestCollection()
        OperationQueue.main.addOperation({
            self.collectionView.reloadSections(IndexSet(0...0))
        })
    }
}
