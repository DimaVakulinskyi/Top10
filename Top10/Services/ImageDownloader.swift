//
//  ImageProvider.swift
//  Top10
//
//  Created by Dmytro Vakulinsky on 09.05.2023.
//

import Foundation
import UIKit

actor ImageDownloader {
    
    static let shared = ImageDownloader()
    
    var cache: [String: UIImage] = [:]
    var tasks: [String: Task<UIImage?, Never>] = [:]
    
    func getImage(with identifier: String) async -> UIImage? {
        if let image = cache[identifier] {
            return image
            
        } else if let task = tasks[identifier] {
            return await task.value
            
        } else {
            let task = Task.detached(priority: .low) {
                do {
                    if let url = URL(string: identifier) {
                        let request = URLRequest(url: url)
                        let (data, _) = try await URLSession.shared.data(for: request)
                        await self.saveCache(data: data, identifier: identifier)
                    } else {
                        print("Invalid URL")
                    }
                } catch {
                    print(error.localizedDescription)
                }
                return await self.cache[identifier]
            }
            tasks[identifier] = task
            return await task.value
        }
    }
    
    func saveCache(data: Data, identifier: String) async {
        cache[identifier] = UIImage(data: data)
    }
}
