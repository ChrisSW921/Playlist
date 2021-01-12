//
//  SongListTableViewController.swift
//  Playlist
//
//  Created by Chris Withers on 1/11/21.
//

import UIKit

class SongListTableViewController: UITableViewController {
    
    
    //MARK: - Outlets
    @IBOutlet weak var songTitleEntry: UITextField!
    @IBOutlet weak var songArtistEntry: UITextField!
    
    
    //MARK: - Properties
    var playlist: Playlist?
    
    
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let songTitle = songTitleEntry.text, !songTitle.isEmpty,
              let songArtist = songArtistEntry.text, !songArtist.isEmpty,
              let currentPlaylist = playlist else { return }
    
        SongController.createSong(title: songTitle, artist: songArtist, playlist: currentPlaylist)
        
        tableView.reloadData()
        songTitleEntry.text = ""
        songArtistEntry.text = ""
        songArtistEntry.resignFirstResponder()
        songTitleEntry.resignFirstResponder()
        
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return playlist?.songs.count ?? 0
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "song", for: indexPath)
        let currentPlaylist = playlist ?? Playlist(title: "Empty", songs: [])
        cell.textLabel?.text = currentPlaylist.songs[indexPath.row].title
        cell.detailTextLabel?.text = currentPlaylist.songs[indexPath.row].artist
        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            guard let currentPlaylist = playlist else {return}
            let songToDelete = currentPlaylist.songs[indexPath.row]
            SongController.deleteSong(songToDelete: songToDelete, playlist: currentPlaylist)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
