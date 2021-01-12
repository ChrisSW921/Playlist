//
//  PlaylistViewController.swift
//  Playlist
//
//  Created by Chris Withers on 1/12/21.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //MARK: - Outlets
    @IBOutlet weak var playlistTextField: UITextField!
    @IBOutlet weak var playlistTableView: UITableView!
    
    //MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        PlaylistController.shared.loadFromPersistenceStore()
        playlistTableView.delegate = self
        playlistTableView.dataSource = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playlistTableView.reloadData()
    }
    
    
    //MARK: - Actions
    @IBAction func createButtonTapped(_ sender: UIButton) {
        guard let newTitle = playlistTextField.text, !newTitle.isEmpty else {return}
        PlaylistController.shared.createPlaylistWith(title: newTitle)
        playlistTableView.reloadData()
        playlistTextField.text = ""
    }
    
    //MARK: - TableView Data Source functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return PlaylistController.shared.playlists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playlistCell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.textColor = .white
        cell.textLabel?.text = PlaylistController.shared.playlists[indexPath.row].title
        cell.detailTextLabel?.text = "\(PlaylistController.shared.playlists[indexPath.row].songs.count) Songs"
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let playlistToDelete = PlaylistController.shared.playlists[indexPath.row]
            PlaylistController.shared.deletePlaylist(playlistToDelete: playlistToDelete)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSongs" {
            guard let indexPath = playlistTableView.indexPathForSelectedRow else {return}
            let selectedPlaylist = PlaylistController.shared.playlists[indexPath.row]
            let destinationVC = segue.destination as? SongListTableViewController
            destinationVC?.playlist = selectedPlaylist
        }
    }
    

}


