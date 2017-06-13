//
//  WebViewController.swift
//  TestDemo
//
//  Created by Jacko Qm on 17/04/2017.
//  Copyright © 2017 Jacko Qm. All rights reserved.
//

import UIKit
import WebKit

/** QMWebViewController是用于展示在App内部网页的VC，内部封装了WKWebView，基本是仿微信App打开网页的方式。你只需要在创建后，传入需要加载的Url字符串即可使用（不一定必须要添加http前缀，然而没有前缀的都会被默认添加https前缀，所以最好还是自己添加了）
 */
class QMWebViewController: UIViewController, WKNavigationDelegate {
    
    private var webView: WKWebView!
    private var progressView: UIProgressView!
    private var titleLabel: UILabel!
    private var previousBarItem: UIBarButtonItem!
    private var timeoutTimer: Timer?
    private var isGoBack: Bool = false
    private var isFirstTime = true
    var requestUrl: String?
    var titleColor: UIColor?
    
    deinit {
        webView.removeObserver(self, forKeyPath: "title")
        
        print("Qm: deinit \(self)")
    }
    
    override func loadView() {
        let configure = WKWebViewConfiguration()
        webView = WKWebView(frame: CGRect.zero, configuration: configure)
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progressView = UIProgressView(progressViewStyle: .bar)
        titleLabel = UILabel()
        previousBarItem = UIBarButtonItem(title: "Previous", style: .plain, target: self, action: #selector(backItemDidPress))
        
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        
        self.navigationItem.leftItemsSupplementBackButton = true
        
        webView.addObserver(self, forKeyPath: "title", options: [.new], context: nil)
        
        if var urlString = requestUrl {
            if !urlString.hasPrefix("http") {
                urlString = "https://" + urlString
            }
            let url = URL(string: urlString)!
            let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
            webView.load(request)
            timeoutTimer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(loadFailureHandler), userInfo: nil, repeats: false)
            webView.addSubview(progressView)
        }
        if let color = titleColor {
            titleLabel.textColor = color
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        //print("Qm: viewDidDisappear")
        timeoutTimer?.invalidate()
        webView.stopLoading()
    }
    
    override func viewWillLayoutSubviews() {
        progressView.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: webView.bounds.width, height: progressView.frame.height))
        progressView.frameY = 64.0
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "title" {
            webViewTitleDidChanged(change![.newKey] as? String)
        }
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!)
    {
        //print("Qm: commit")
        timeoutTimer?.invalidate()
        self.navigationItem.rightBarButtonItem = (webView.canGoBack == true) ? previousBarItem : nil
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        //print("Qm: Start")
        guard !isGoBack else {
            isGoBack = false
            return
        }
        progressView.isHidden = false
        if !isFirstTime {
            progressView.progress = 0.0
        } else {
            progressView.progress = 0.1
            isFirstTime = false
        }
        progressView.layoutIfNeeded()
        
        UIView.animateKeyframes(withDuration: 15.0, delay: 0.0, animations: {
            self.progressView.progress = 0.6
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 0.03) {
                self.progressView.layoutIfNeeded()
            }
            self.progressView.progress = 0.85
            UIView.addKeyframe(withRelativeStartTime: 0.03, relativeDuration: 0.3) {
                self.progressView.layoutIfNeeded()
            }
            self.progressView.progress = 0.95
            UIView.addKeyframe(withRelativeStartTime: 0.3, relativeDuration: 1.0) {
                self.progressView.layoutIfNeeded()
            }
        })
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!)
    {
        //print("Qm: Finished")
        progressView.setProgress(1.0, animated: true)
        
        UIView.animate(withDuration: 0.3, delay: 0.6, options: .curveEaseOut, animations: {
            self.progressView.alpha = 0.0
        }) { (_) in
            self.progressView.isHidden = true
            self.progressView.alpha = 1.0
        }
        
    }
    
    @objc
    private func backItemDidPress()
    {
        if webView.canGoBack {
            progressView.isHidden = true
            isGoBack = true
            webView.goBack()
        }
    }
    
    @objc
    private func loadFailureHandler()
    {
        progressView.isHidden = true;
        let alertVC = UIAlertController(title: "Ah-oh!", message: "加载失败！请检查网址后重试！", preferredStyle: .alert)
        let action = UIAlertAction(title: "我知道了", style: .default) { _ in
            if let nav = self.navigationController {
                nav.popViewController(animated: true)
            }
        }
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    private func webViewTitleDidChanged(_ title: String?)
    {
        if let nav = self.navigationController, let title = title {
            titleLabel.text = title
            titleLabel.sizeToFit()
            let navBar = nav.navigationBar
            titleLabel.center = CGPoint(x: navBar.bounds.width/2, y: navBar.bounds.height/2)
            self.navigationItem.titleView = titleLabel
        }
    }
}
