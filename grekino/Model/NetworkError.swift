//
//  NetworkError.swift
//  grekino
//
//  Created by Zach Freeman on 7/14/25.
//

enum NetworkError: Error {
    case decodingError
    case noData
    case noInternet
    case badURL
    case unknown
}
