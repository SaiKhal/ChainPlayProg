//
//  File.swift
//  ChainPlayProg
//
//  Created by Masai Young on 9/17/18.
//  Copyright © 2018 Masai Young. All rights reserved.
//

import Foundation

struct MediaItem {
    let title: String
    let url: URL
    
    static let movies: [MediaItem] = {
        let movieTitles = ["Snow Mountain", "Table Ronde", "Animated Movie", "Timelapse", "Parkour", "Bird"]
        let movieURLS: [URL] = ["https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8",
                                "https://mnmedias.api.telequebec.tv/m3u8/29880.m3u8",
                                "http://184.72.239.149/vod/smil:BigBuckBunny.smil/playlist.m3u8",
                                "https://bitmovin-a.akamaihd.net/content/playhouse-vr/m3u8s/105560.m3u8",
                                "https://bitdash-a.akamaihd.net/content/MI201109210084_1/m3u8s/f08e80da-bf1d-4e3d-8899-f0f6155f6efa.m3u8",
                                "https://devimages-cdn.apple.com/samplecode/avfoundationMedia/AVFoundationQueuePlayer_HLS2/master.m3u8",
                                ].compactMap(URL.init)
        
        let movies = zip(movieTitles, movieURLS).map { MediaItem(title: $0, url: $1) }
        return movies
    }()
}


