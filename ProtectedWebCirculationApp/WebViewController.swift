//
//  WebViewController.swift
//  ProtectedWebCirculationApp
//
//  Created by Eren Elçi on 27.09.2024.
//

import UIKit
import WebKit

class WebViewController: UIViewController , WKNavigationDelegate {
    
    var webViwe: WKWebView!
    var progressView: UIProgressView!
    var selectedFirstWeb: String = ""
    var firstUrl: String = ""
    var websites = [ "github.com","apple.com", "hackingwithswift.com","google.com","haber7.com"]
    
    
    override func loadView() {
        print("görünüm yüklenirken çağrıldı")
        webViwe = WKWebView()
        webViwe.navigationDelegate = self
        view = webViwe
        firstUrl = "https://" + selectedFirstWeb
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("görünüm yüklendikten sonra çağrıldı")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Open", style: UIBarButtonItem.Style.plain, target: self, action: #selector(openTapped))
        
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        let refresh = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: webViwe, action: #selector(webViwe.reload))
        
        let back = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.undo, target: webViwe, action: #selector(WKWebView.goBack))
        let forward = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.fastForward, target: webViwe, action: #selector(WKWebView.goForward))
        
        // progress barı oluşturma kodu
        progressView = UIProgressView(progressViewStyle: UIProgressView.Style.default)
        progressView.sizeToFit()
        let progressButton = UIBarButtonItem(customView: progressView)
        
        
        
        toolbarItems = [progressButton ,spacer,back,forward,  refresh]
        navigationController?.isToolbarHidden = false
        
        webViwe.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress),options: .new , context: nil)
        
        
        let url = URL(string: firstUrl)!
        webViwe.load(URLRequest(url: url))
        webViwe.allowsBackForwardNavigationGestures = true
    }
    
    
    @objc func openTapped(){
        let ac = UIAlertController(title: "Open Page ", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        for website in websites {
            ac.addAction(UIAlertAction(title: website, style: UIAlertAction.Style.default, handler: openPage))
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel))
        present(ac, animated: true)
    }
    
    func openPage(action: UIAlertAction){
        guard let actionTitle  = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webViwe.load(URLRequest(url: url))
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webViwe.estimatedProgress)
        }
    }
    
    
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            // Sadece ana çerçeve navigasyonlarını kontrol et
            if navigationAction.targetFrame?.isMainFrame ?? false {
                let url = navigationAction.request.url
                if let host = url?.host?.lowercased() {
                    print("Ziyaret edilen host: \(host)") // Debug için host'u yazdırın
                    for website in websites {
                        let websiteLowercased = website.lowercased()
                        if host == websiteLowercased || host.hasSuffix(".\(websiteLowercased)") {
                            decisionHandler(.allow)
                            print("İzin verilen siteye erişim: \(host)")
                            return
                        }
                    }
                }
                
                // Engellenen siteye giriş yapıldığında uyarı mesajı göster
                let alert = UIAlertController(title: "Uyarı Mesajı", message: "Bu siteye giriş engellenmiştir", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Tamam", style: .cancel, handler: nil))
                
                decisionHandler(.cancel)
                print("Engellenen siteye erişim denemesi: \(url?.absoluteString ?? "Bilinmiyor")")
                
                // Alert'i sunmak için ana kuyruğa taşıma
                DispatchQueue.main.async {
                    self.present(alert, animated: true)
                }
            } else {
                // Ana çerçeve dışındaki navigasyonlar için izin ver
                decisionHandler(.cancel)
            }
        }
    
}
