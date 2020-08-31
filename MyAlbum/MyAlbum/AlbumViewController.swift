//
//  ViewController.swift
//  MyAlbum
//
//  Created by ggyool on 2020/08/30.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit
import Photos

class AlbumViewController: UIViewController, UICollectionViewDataSource {
    
    
    let cellIdentifier:String = "cell"
    
    var thumbnailResult: PHFetchResult<PHCollection>!
    var imageManager: PHCachingImageManager = PHCachingImageManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        if(authorizePhotoLibrary()){
            requestCollection()
        }
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
        
        guard let cameraRoll: PHAssetCollection = cameraRollResult.firstObject,
            let favorites: PHAssetCollection = favoriteResult.firstObject else {
                return
        }
        
        
        // 한개만 가져올 수는 좋은 방법은 없는지
        let fetchOptions = PHFetchOptions()
        // fetchOptions.fetchLimit = 1
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: false)]
        print(PHAsset.fetchAssets(in: cameraRoll, options: fetchOptions))
        
        

        
        
//        
//        for i in 0..<userAlbums.count {
//            if let res: PHAssetCollection? = userAlbums.object(at: i) {
//                print(res)
//            }
//        }
        
        print("end")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return thumbnailResult.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }


}

