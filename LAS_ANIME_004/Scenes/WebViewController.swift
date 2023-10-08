//
//  WebViewController.swift
//  LAS_ANIME_004
//
//  Created by Khanh Vu on 06/10/2023.
//

import UIKit
import WebKit
import SVProgressHUD

class WebViewController: BaseViewController {

    @IBOutlet weak var webView: WKWebView!
    var urlString: String!
    var url: URL!
    var didLoadVideo = false

    var embedVideoHtml:String {
        return """
            <!DOCTYPE html>
            <html>
            <body>
            <!-- 1. The <iframe> (and video player) will replace this <div> tag. -->
            <div id="player"></div>
            
            <script>
            var tag = document.createElement('script');
            
            tag.src = "https://www.youtube.com/iframe_api";
            var firstScriptTag = document.getElementsByTagName('script')[0];
            firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
            
            var player;
            function onYouTubeIframeAPIReady() {
            player = new YT.Player('player', {
            height: '\(view.frame.height)',
            width: '\(view.frame.width)',
            videoId: '\(url.lastPathComponent)',
            events: {
            'onReady': onPlayerReady
            }
            });
            }
            
            function onPlayerReady(event) {
            event.target.playVideo();
            }
            </script>
            </body>
            </html>
            """
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ActivityIndicatorUtility.hide()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if !didLoadVideo {
            webView.loadHTMLString(embedVideoHtml, baseURL: nil)
            didLoadVideo = true
        }
    }

    func setUpUI() {
        let webViewConfiguration = WKWebViewConfiguration()
        webViewConfiguration.allowsInlineMediaPlayback = true
        webView.configuration.allowsInlineMediaPlayback = true
        webView.navigationDelegate = self
        guard let url = URL(string: urlString) else {
            return
        }
        self.url = url
        let request = URLRequest(url: url)
        webView.load(request)
        ActivityIndicatorUtility.show()
    }
    
    @IBAction func doneClick(_ sender: Any) {
        ActivityIndicatorUtility.hide()
        self.dismiss(animated: true, completion: nil)
    }
}

extension WebViewController: WKNavigationDelegate {

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // This method is called when the web view finishes loading a page.
        print("finish")
//        webView.loadHTMLString(embedVideoHtml, baseURL: nil)
    

        ActivityIndicatorUtility.hide()
//        ProgressActivity.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // This method is called when there is an error during navigation.
        print("faild")
        ActivityIndicatorUtility.hide()

//        ProgressActivity.hideActivityIndicator()
    }
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        ActivityIndicatorUtility.hide()
    }
    
    
}

//extension WebViewController: WKScriptMessageHandler {
//
//}
