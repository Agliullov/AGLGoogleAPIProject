//
//  TypesHelper.swift
//  AGLGoogleAPIProject
//
//  Created by Ильдар Аглиуллов on 11.02.2023.
//

import UIKit

extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else { return nil }
        return self[index]
    }
}

extension UISearchController {
    
    private static let defaultLeftView: UIView = {
        UISearchTextField().leftView ?? UIView()
    }()
    
    private static let leftViewSize: CGSize = {
        UISearchTextField().leftView?.frame.size ?? .zero
    }()
    
    private static let loadingLeftView: UIView = {
        let view = UIView(frame: .init(origin: .zero, size: leftViewSize))
        
        let activityIndicatorView = UIActivityIndicatorView(style: .medium)
        activityIndicatorView.transform = .init(scaleX: 0.9, y: 0.9)
        activityIndicatorView.startAnimating()
        
        view.addSubview(activityIndicatorView)
        
        activityIndicatorView.center = CGPoint(x: leftViewSize.width / 2, y: leftViewSize.height / 2)
        
        return view
    }()
    
    func startLoading() {
        searchBar.searchTextField.leftView = Self.loadingLeftView
    }
    
    func stopLoading() {
        searchBar.searchTextField.leftView = Self.defaultLeftView
    }
}
