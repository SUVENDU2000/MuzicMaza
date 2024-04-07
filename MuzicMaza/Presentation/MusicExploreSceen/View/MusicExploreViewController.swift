//
//  MusicExploreViewController.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 06/04/24.
//

import UIKit

class MusicExploreViewController: UIViewController {
    
    @IBOutlet weak var musicImageCollectionView: UICollectionView!
    @IBOutlet weak var progressBar: UIProgressView!
    @IBOutlet weak var startTime: UILabel!
    @IBOutlet weak var endTime: UILabel!
    @IBOutlet weak var musicName: UILabel!
    @IBOutlet weak var subMusicName: UILabel!
    
    private var songDataForFullView: AllSongsData?
    var selectedImage: UIImage?
    var selectedMusicName: String?
    var selectedSubMusicName: String?
    let musicPlayer = MusicPlayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        musicImageCollectionView.delegate = self
        musicImageCollectionView.dataSource = self
        musicImageCollectionView.registerCell(MusicExploreCollectionCell.self)
        musicName.text = selectedMusicName
        subMusicName.text = selectedSubMusicName
    }
    
    @IBAction func backWardButton(_ sender: UIButton) {
        // Handle backward button action
    }
    
    @IBAction func playAndPauseButton(_ sender: UIButton) {
        
    }
    
    @IBAction func forwardButton(_ sender: UIButton) {
        // Handle forward button action
    }
}

extension MusicExploreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songDataForFullView?.data.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let urlString = songDataForFullView?.data[indexPath.row].url
        print("-----------", urlString)
        let cell = collectionView.dequeueReusableCell(ofType: MusicExploreCollectionCell.self, for: indexPath)
        let url = URL(string: " ")!
        cell.musicFullImaheView.image = UIImage(named: songDataForFullView?.data[indexPath.row].cover ?? "headPhone")
        musicPlayer.play(url: url)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.width
        let height: CGFloat = collectionView.frame.height
        return CGSize(width: width, height: height)
    }
}
