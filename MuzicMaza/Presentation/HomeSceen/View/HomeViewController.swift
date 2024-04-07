//
//  HomeViewController.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 05/04/24.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var songsTableView: UITableView!
    
    private var songData: AllSongsData?
    private var selectedCell: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        songsTableView.delegate = self
        songsTableView.dataSource = self
        songsTableView.registerCell(HomeTableViewCell.self)
        getData()
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songData?.data.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(ofType: HomeTableViewCell.self, for: indexPath)
        cell.musicImageView.image = UIImage(named: songData?.data[indexPath.row].cover ?? "headPhone")
        cell.musicName.text = songData?.data[indexPath.row].name
        cell.subMusicName.text = songData?.data[indexPath.row].artist
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCell = indexPath.row
        guard let cell = songsTableView.cellForRow(at: indexPath) as? HomeTableViewCell else {
            return
        }
        let storyboard = UIStoryboard(name: "MusicExploreViewController", bundle: nil)
           let musicExploreVC = storyboard.instantiateViewController(withIdentifier: "MusicExploreViewController") as! MusicExploreViewController
           
           // Pass data to MusicExploreViewController if needed
           musicExploreVC.selectedImage = UIImage(named: songData?.data[indexPath.row].cover ?? "headPhone")
           musicExploreVC.selectedMusicName = songData?.data[indexPath.row].name
           musicExploreVC.selectedSubMusicName = songData?.data[indexPath.row].artist
           
           // Set transitioning delegate for custom animation
           musicExploreVC.transitioningDelegate = self
           
           // Present MusicExploreViewController with custom animation
           present(musicExploreVC, animated: false, completion: nil)
    }
}

extension HomeViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return MorphTransitionAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

extension HomeViewController {
    
    func getData() {
        let urlString = "https://cms.samespace.com/items/songs"
        NetworkManager.shared.fetchData(from: urlString, responseType: AllSongsData.self) { result in
                    switch result {
                    case .success(let data):
                        self.songData = data
                        DispatchQueue.main.async {
                            self.songsTableView.reloadData()
                        }
                        print("Received data: \(data)")
                    case .failure(let error):
                        print("Error fetching data: \(error)")
                        
                    }
                }
    }
}
