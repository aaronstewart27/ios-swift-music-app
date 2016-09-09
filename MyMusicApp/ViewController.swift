//
//  ViewController.swift
//  MyMusicApp
//
//  Created by Aaron Stewart on 4/15/16.
//  Copyright © 2016 Aaron Stewart. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AVFoundation

class ViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var search: UITextField!
    
    @IBOutlet weak var results: UITableView!
    
    
    struct Music {
        var title: String
        var streamURL: String
        var userName: String
        var artworkURL: String
        var duration: NSNumber
    }
    
    var musicData:Array<Music> = []
    
    var audioPlayer = AVPlayer()
    
    @IBAction func searchPressed(sender: SearchInput) {
        
        self.musicData.removeAll()
        
        if let st = search.text {
            
            let API_URL = "http://api.soundcloud.com/tracks/?q=" + st + "&client_id=5f61421beef03933a192f6ea1266e293"
            
            Alamofire.request(.GET, API_URL)
                .responseJSON { _, _, result in
                    if let items = JSON(result.value!).array {
                        for item in items {
                            let m = Music(
                                title: item["title"].string!,
                                streamURL: item["stream_url"].string!,
                                userName: item["user"]["username"].string!,
                                artworkURL: item["artwork_url"] != nil ? item["artwork_url"].string! : "http://placehold.it/50x50",
                                duration: item["duration"].number!
                            )
                            self.musicData.append(m)
                        }
                        self.results.reloadData()
                    }
            }
        }
    }
    
//    @IBAction func searchButton(sender: UIButton) {
//        
//        self.musicData.removeAll()
//        
//        if let st = search.text {
//
//            let API_URL = "http://api.soundcloud.com/tracks/?q=" + st + "&client_id=5f61421beef03933a192f6ea1266e293"
//            
//            Alamofire.request(.GET, API_URL)
//                .responseJSON { _, _, result in
//                    if let items = JSON(result.value!).array {
//                        for item in items {
//                            if let title = item["title"].string {
//                                let m = Music(title: title, streamURL: item["stream_url"].string!)
//                                self.musicData.append(m)
//                            }
//                        }
//                        self.results.reloadData()
//                    }
//            }
//        }
//    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return musicData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customcell", forIndexPath: indexPath) as! SearchResultCell
        
        cell.artist?.text = musicData[indexPath.row].userName
        cell.songTitle?.text = musicData[indexPath.row].title
        
        if let artworkURL = NSURL(string: self.musicData[indexPath.row].artworkURL) {
            if let data = NSData(contentsOfURL: artworkURL) {
                cell.artwork.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.results.dataSource = self
        
        
        // Test streaming audio
//        do {
//            let url = "https://api.soundcloud.com/tracks/135876607/stream?client_id=050698f9be498c85b447f917ebc8482b"
//            let fileURL = NSURL(string:url)
//            self.audioPlayer = try AVPlayer(URL: fileURL!)
//            audioPlayer.volume = 1.0
//            audioPlayer.play()
//        } catch {
//            print("Error getting the audio file")
//        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let playerView = segue.destinationViewController as! PlayerViewController
        
        if let customcell = sender as? UITableViewCell {
            playerView.artist = self.musicData[(results.indexPathForCell(customcell)?.row)!].userName
            playerView.songTitle = self.musicData[(results.indexPathForCell(customcell)?.row)!].title
            playerView.streamURL = self.musicData[(results.indexPathForCell(customcell)?.row)!].streamURL
            playerView.artURL = self.musicData[(results.indexPathForCell(customcell)?.row)!].artworkURL
        
        }
    }
    
}
    


