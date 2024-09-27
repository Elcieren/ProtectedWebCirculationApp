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

</details>
