//
//  ImageLoader.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 06.02.2023.
//

import Combine
import UIKit

final class ImageLoader {
    
    static let shared: ImageLoader = ImageLoader()
    
    private let cache: ImageCacheProtocol
    
    private lazy var backgroundQueue: OperationQueue = {
        let queue = OperationQueue()
        queue.qualityOfService = .userInteractive
        queue.maxConcurrentOperationCount = 50
        return queue
    }()
    
    init(cache: ImageCacheProtocol = ImageCache()) {
        self.cache = cache
    }
    
    func loadImage(from url: URL) -> AnyPublisher<UIImage?, Never> {
        if let image = cache[url] {
            return Just(image).eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: url)
            .map { (data, response) -> UIImage? in return UIImage(data: data) }
            .catch { error in return Just(nil) }
            .handleEvents(receiveOutput: { [unowned self] image in
                guard let image = image else { return }
                self.cache[url] = image })
            .subscribe(on: backgroundQueue)
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    func clear() {
        self.cache.removeAllImages()
    }
}
