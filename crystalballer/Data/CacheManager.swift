import Foundation
import SwiftUI

class CacheManager {
    static let shared = CacheManager()
    private let cache = NSCache<NSString, CacheEntry>()
    
    // Cache duration of 1 hour
    private let cacheDuration: TimeInterval = 3600
    
    private init() {
        cache.countLimit = 100
        cache.totalCostLimit = 50 * 1024 * 1024
    }
    
    func cache(_ matches: [Match], forDate date: Date) {
        let key = dateKey(for: date)
        let entry = CacheEntry(matches: matches, timestamp: Date())
        cache.setObject(entry, forKey: key as NSString)
    }
    
    func getMatches(forDate date: Date) -> [Match]? {
        let key = dateKey(for: date)
        guard let entry = cache.object(forKey: key as NSString),
              !entry.isExpired(duration: cacheDuration) else {
            return nil
        }
        return entry.matches
    }
    
    func clearCache() {
        cache.removeAllObjects()
    }
    
    private func dateKey(for date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
}

class CacheEntry {
    let matches: [Match]
    let timestamp: Date
    
    init(matches: [Match], timestamp: Date) {
        self.matches = matches
        self.timestamp = timestamp
    }
    
    func isExpired(duration: TimeInterval) -> Bool {
        return Date().timeIntervalSince(timestamp) > duration
    }
}
