//
//  ViewController.swift
//  CollectionViewExam
//
//  Created by ggyool on 2020/08/29.
//  Copyright © 2020 ggyool. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    let cellIdentifier: String = "cell"
    var friends: [Friend] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let flowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets.zero // edge padding
        flowLayout.minimumInteritemSpacing = 10 // 최소 item 간 거리
        flowLayout.minimumLineSpacing = 10 // 줄 간의 최소 거리

        let halfWidth: CGFloat = UIScreen.main.bounds.width/2.0
        // 잘 동작하는지 모르겠다 item 간 거리를 작게하면 3개씩 들어감
        //flowLayout.estimatedItemSize = CGSize(width: halfWidth-30, height: 90)
        
        flowLayout.itemSize = CGSize(width: halfWidth-30, height: 90)
        
        self.collectionView.collectionViewLayout = flowLayout
        
        let jsonDecoder = JSONDecoder()
        guard let dataAsset = NSDataAsset(name: "friends") else {
            return
        }
        do {
            self.friends = try jsonDecoder.decode([Friend].self, from: dataAsset.data)
        }
        catch {
            print(error.localizedDescription)
        }
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return friends.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell: FriendCollectionViewCell = collectionView.dequeueReusableCell(
            withReuseIdentifier: cellIdentifier, for: indexPath) as? FriendCollectionViewCell else {
                assertionFailure("error")
                // 이렇게 처리해도 되는 것인지?
                return UICollectionViewCell()
        }
        let friend = friends[indexPath.item]
        
        cell.nameAgeLabel.text = friend.nameAndAge
        cell.addressLabel.text = friend.fullAddress
        return cell
    }
    
    // delegate protocol methods
//    func collectionView(    _ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        self.numberOfCell += 1
//        collectionView.reloadData()
//    }


}

