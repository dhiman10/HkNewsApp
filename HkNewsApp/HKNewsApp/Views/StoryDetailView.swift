//
//  StoryDetailView.swift
//  HKNewsApp
//
//  Created by Dhiman Das on 3/3/23.
//

import UIKit
import WebKit


class StoryDetailView: UIView, WKNavigationDelegate {

     private var viewModel : StoryDetailViewModel?
    
    lazy var webView: WKWebView = {
        let wv = WKWebView()
        wv.navigationDelegate = self
        wv.translatesAutoresizingMaskIntoConstraints = false
        return wv
    }()


    public var storyId : Int?
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        addSubview(webView)
        addConstraints()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    private func addConstraints() {

        NSLayoutConstraint.activate([
            
            webView.leftAnchor.constraint(equalTo: leftAnchor),
            webView.topAnchor.constraint(equalTo: topAnchor),
            webView.rightAnchor.constraint(equalTo: rightAnchor),
            webView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
    }
    
    
    
    public func configure(with viewModel : StoryDetailViewModel) {
        self.viewModel = viewModel
        
        guard let urlstring = self.viewModel?.url else{
            return
        }
        
        let url = URL(string: urlstring)
        guard let url = url else {
            return
        }
        webView.load(URLRequest(url: url))
      
    }
    
}
