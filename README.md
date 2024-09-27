<details>
<summary><h2>Uygulama İçeriği</h2></summary>

  <details>
    <summary><h2>loadView()</h2></summary>
    `loadView()` metodu, `WebViewController` için ana görünümü oluşturmak üzere kullanılır. Bu metod, görünüm hiyerarşisini programatik olarak oluşturmak için idealdir.
    
    ```swift
    override func loadView() {
        webViwe = WKWebView()
        view = webViwe
        firstUrl = "https://" + selectedFirstWeb
    }
    ```
  </details> 

  <details>
    <summary><h2>WKWebView</h2></summary>
    `WKWebView`, web içeriklerini uygulama içinde görüntülemek için kullanılır. Bu proje kapsamında, kullanıcı tarafından seçilen web sitesi bu bileşen aracılığıyla yüklenir ve görüntülenir.
    
    ```swift
    var webViwe: WKWebView!
    ```
  </details> 

  <details>
    <summary><h2>Delegation</h2></summary>
    Delegasyon, belirli olayları ve etkileşimleri yönetmek için kullanılır. Bu projede, `UITableView` ve `WKWebView` için delegasyon kullanılarak kullanıcı etkileşimleri ve navigasyon olayları yönetilmektedir.
    
    ```swift
    class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
        // ...
        tableView.delegate = self
        tableView.dataSource = self
    }
    ```
  </details> 

  <details>
    <summary><h2>URLRequest</h2></summary>
    RLRequest, belirli bir URL'ye yapılacak HTTP isteğini temsil eder. Bu, web sayfasının yüklenmesi için gerekli bilgileri içerir.
    
    ```swift
    webViwe.load(URLRequest(url: url))
    ```
  </details> 


  <details>
    <summary><h2>UIProgressView</h2></summary>
    UIProgressView, bir işlemin ilerlemesini görsel olarak göstermek için kullanılır. Bu projede, web sayfasının yüklenme sürecini kullanıcıya göstermek için kullanılır
    
    ```swift
    progressView = UIProgressView(progressViewStyle: .default)
    progressView.sizeToFit()
    let progressButton = UIBarButtonItem(customView: progressView)

    ```
  </details> 


<details>
    <summary><h2>decidePolicyFor</h2></summary>
   decidePolicyFor metodu, WKWebView'in hangi URL'lere izin vereceğini veya engelleyeceğini belirlemek için kullanılır. Bu sayede, sadece belirlenen web sitelerine erişim sağlanır ve    diğer siteler engellenir.
    
    ```swift
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    // ... kontrol ve karar verme mantığı
    }

    ```
  </details> 

  <details>
    <summary><h2>observeValue</h2></summary>
   observeValue metodu, gözlemlenen bir özelliğin (bu projede WKWebView'in estimatedProgress özelliği) değeri değiştiğinde çağrılır. Bu, sayfa yüklenme ilerlemesini takip etmek için    kullanılır.
    
    ```swift
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
    if keyPath == "estimatedProgress" {
        progressView.progress = Float(webViwe.estimatedProgress)
    }
    }


    ```
  </details> 
   
</details>
