//
//  songController.swift
//  Playlist
//
//  Created by Chris Withers on 1/11/21.
//

import Foundation

class SongController {
    
   static func createSong(title: String, artist: String, playlist: Playlist) {
        let newSong = Song(title: title, artist: artist)
        playlist.songs.append(newSong)
        PlaylistController.shared.saveToPersistenceStore()
    }
    
   static func deleteSong(songToDelete: Song, playlist: Playlist){
        guard let index = playlist.songs.firstIndex(of: songToDelete) else { return }
        playlist.songs.remove(at: index)
        PlaylistController.shared.saveToPersistenceStore()
    }
}

