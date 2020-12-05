//
//  ViewController.swift
//  simple_youtube
//
//  Created by 윤재웅 on 2020/12/04.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ModelDelegate {
    
    
    @IBOutlet weak var tableVIew: UITableView!
    
    // Model 객체 생성
    var model = Model()
    var videos: [Video] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set itself as the datasource and the delegate
        tableVIew.dataSource = self
        tableVIew.delegate = self
        
        // Set itself as the delegate of the model
        model.delegate = self
        
        model.getVideos()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Confirm that a video was selected
        guard tableVIew.indexPathForSelectedRow != nil else {
            return
        }
        
        // Get a reference to the video that was tapped on
        let selectedVideo = videos[tableVIew.indexPathForSelectedRow!.row]
        
        // Get a reference to detail view controller
        let detailVC = segue.destination as! DetailViewController
        
        // Set the video property of the detail view controller
        detailVC.video = selectedVideo
        
    }
    
    // MARK: - Model Delegate Methods
    func videosFetched(_ videos: [Video]) {
        // Set the returned videos to our video property
        self.videos = videos
        
        // Refresh the tableview
        DispatchQueue.main.async {
            self.tableVIew.reloadData()
        }
        
    }
    
    // MARK: - TableView Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.VIDEOCELL_ID, for: indexPath) as! VideoTableViewCell
        
        // Configure the cell with the data
        // Get the title for the video in question
        let video = self.videos[indexPath.row]
        
        cell.setCell(video)
        
        // Return the cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

