//
//  GithubJsonService.swift
//  BaseRxswift_MVVM
//
//  Created by Khanh Vu on 28/09/2023.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class GithubJsonService {
    static let shared = GithubJsonService()
    
    func makeRequest<T: Codable>(type: T.Type, request: URLRequest, completion: @escaping (T?) -> Void) {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async { completion(response) }
                
            } catch {
                DispatchQueue.main.async { completion(nil) }
            }
        }
        task.resume()
    }
    func fetchDataList<T: Decodable>(from url: URL, completion: @escaping (Result<[T], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                print(json)
                
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([T].self, from: data)
                completion(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    
    func fetchData<T: Decodable>(from url: URL, completion: @escaping (Result<T, Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any]
                print(json)
                
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                print(error.localizedDescription)
                completion(.failure(NetworkError.decodingError))
            }
        }.resume()
    }
    let apiKey = "AIzaSyApTnh0thpYzL5n1WzHZmt9Gfk91mzYLgY"
    
    func fetchYouTubeThumbnail(shortUrl: String, completion: @escaping (URL?) -> Void) {
        // Construct the URL to fetch video details from YouTube
        let id = getId(url: shortUrl)
        let apiUrl = "https://www.googleapis.com/youtube/v3/videos?key=\(apiKey)&part=snippet&id=\(id)"
        
        if let url = URL(string: apiUrl) {
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                    print(json)
                    if let items = json["items"] as? [[String: Any]], let item = items.first,
                       let snippet = item["snippet"] as? [String: Any],
                       let thumbnails = snippet["thumbnails"] as? [String: Any],
                       let defaultThumbnail = thumbnails["standard"] as? [String: Any],
                       let thumbnailUrlString = defaultThumbnail["url"] as? String,
                       let thumbnailUrl = URL(string: thumbnailUrlString) {
                           completion(thumbnailUrl)
                           return
                    }
                }
                // If something goes wrong, return nil
                completion(nil)
            }
            task.resume()
        } else {
            completion(nil)
        }
    }
    
    func getId(url: String) -> String {
        let components = url.components(separatedBy: "/")
        guard let videoID = components.last  else {
            print("Failed to extract video ID.")
            return ""
        }
        return videoID
    }
}
