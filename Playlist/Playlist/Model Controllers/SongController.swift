//
//  songController.swift
//  Playlist
//
//  Created by Chris Withers on 1/11/21.
//

import Foundation

class SongController {
    
    //shared instance
    static let shared = SongController()
    
    //source of truth (S.O.T)
    var songs: [Song] = []
    
    func createSong(title: String, artist: String) {
        let newSong = Song(title: title, artist: artist)
        songs.append(newSong)
        saveToPersistenceStore()
    }
    
    func deleteSong(songToDelete: Song){
        guard let index = songs.firstIndex(of: songToDelete) else { return }
        songs.remove(at: index)
        saveToPersistenceStore()
        
        
    }
    
    //MARK: -Persistence
    
    //fileURL
    func fileURL() -> URL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let fileURL = urls[0].appendingPathComponent("playlist.json")
        return fileURL
        
    }
    
    //save
    func saveToPersistenceStore() {
        do{
            let data = try JSONEncoder().encode(songs)
            try data.write(to: fileURL())
        }catch{
            print("Error saving data: \(error.localizedDescription)")
        }
    }
    
    //load
    func loadFromPersistenceStore() {
        do{
            let data = try Data(contentsOf: fileURL())
            songs = try JSONDecoder().decode([Song].self, from: data)
        }catch {
            print("Error loading data \(error.localizedDescription)")
        }
       
    }

    
    
    
}
