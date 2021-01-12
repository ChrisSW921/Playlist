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
    
    
    
    
    
    //MARK: - Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        SongController.shared.loadFromPersistenceStore()
    }
    
    
    //MARK: - Actions
    @IBAction func addButtonTapped(_ sender: Any) {
        
        guard let songTitle = songTitleEntry.text, !songTitle.isEmpty,
              let songArtist = songArtistEntry.text, !songArtist.isEmpty else { return }
        
        SongController.shared.createSong(title: songTitle, artist: songArtist)
        
        tableView.reloadData()
        songTitleEntry.text = ""
        songArtistEntry.text = ""
        songArtistEntry.resignFirstResponder()
        songTitleEntry.resignFirstResponder()
        
    }
    
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return SongController.shared.songs.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "song", for: indexPath)
        cell.textLabel?.text = SongController.shared.songs[indexPath.row].title
        cell.detailTextLabel?.text = SongController.shared.songs[indexPath.row].artist
    

        return cell
    }

    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let songToDelete = SongController.shared.songs[indexPath.row]
            SongController.shared.deleteSong(songToDelete: songToDelete)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
}
