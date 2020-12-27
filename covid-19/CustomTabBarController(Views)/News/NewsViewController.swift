//
//  NewsViewController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 11/2/20.
//

import UIKit

class NewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var articles: [Article] = []
    let apiKey = "24bec7253bf0482b91794044d8ed95ea"
//    extension article
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getNewsData()
        
    }
    
    private func getNewsData(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        guard let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)&category=health") else {return}

        let urlRequest  = URLRequest(url: url)
        let datatask = session.dataTask(with: urlRequest) { (data,respond,error) in
        if let data = data {
            let decoder = JSONDecoder()

            if let parsedNews = try? decoder.decode(NewsRespond.self, from: data){
                self.articles = parsedNews.articles
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                    
            } else {print("Something wrong")}
        }
        }
        datatask.resume()
    }
    
    
    // MARK: - Properties
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCell")
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        let article = articles[indexPath.item]
        
        cell.titleLabel.text = article.title
        cell.authorLabel.text = article.author
        // add bgimage
        if let link = article.urlToImage {
                cell.newsImageView.image = loadImageFromUrl(StringUrl: link)
        } else {
            //cell.newsImageView.image = UIImage(named: "no_image.png")
            
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentArticle = articles[indexPath.item].url {
        guard let url = URL(string: currentArticle) else { return }
            UIApplication.shared.open(url)}
    }
    
    func loadImageFromUrl(StringUrl: String) -> UIImage? {
        if  let url = URL(string: StringUrl){
            if let data = try? Data(contentsOf: url) {
                    
                if let image = UIImage(data: data) {
                    return image
                }
            }
        }
            return nil
    }

    func applyMonoFilter(_ image: UIImage) -> UIImage? {
      guard let data = image.pngData() else { return nil }
      let inputImage = CIImage(data: data)
      let context = CIContext(options: nil)
      guard let filter = CIFilter(name: "CIPhotoEffectMono") else { return nil }
      filter.setValue(inputImage, forKey: kCIInputImageKey)
      guard
        let outputImage = filter.outputImage,
        let outImage = context.createCGImage(outputImage, from: outputImage.extent)
      else {
        return nil
      }
      return UIImage(cgImage: outImage)
    }
    
}

// MARK: - UI Setup
extension NewsViewController {
    private func setupUI() {
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        }
        self.view.backgroundColor = .white
        
        self.view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
    }
    
    private func collectionViewLayout() -> UICollectionViewLayout {
        let cellSizeInPercentsFromScreenBounds = 0.45
        let layout = UICollectionViewFlowLayout()
        let cellWidthHeightConstant: CGFloat = UIScreen.main.bounds.width * CGFloat(cellSizeInPercentsFromScreenBounds)
        let space = (UIScreen.main.bounds.width-cellWidthHeightConstant*2)/3
        layout.sectionInset = UIEdgeInsets(top: space,
                                           left: space,
                                           bottom: space,
                                           right: space)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: cellWidthHeightConstant, height: cellWidthHeightConstant)
        
        return layout
    }
    

}

    


/*class NewsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate{

    

    var articles: [Article] = []
    let apiKey = "24bec7253bf0482b91794044d8ed95ea"
    var newsCollectionView: UICollectionView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view = UIView()
        view.backgroundColor = .white
        self.title = "News"
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
            layout.itemSize = CGSize(width: 150, height: 150)
        
        newsCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        newsCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        newsCollectionView?.backgroundColor = UIColor.white
        newsCollectionView?.dataSource = self
        newsCollectionView?.delegate = self
        

        self.view.addSubview(newsCollectionView ?? UICollectionView())
}
    

func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return articles.count
}

func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let currentArticle = articles[indexPath.item]
    let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
    myCell.backgroundColor = UIColor.red
    // add bgimage
    let newsImage = UIImageView(frame: myCell.frame)
    if let link = currentArticle.urlToImage {
        newsImage.load(StringUrl: link)
    } else {
        newsImage.image = UIImage(named: "no_image.png")}
    myCell.addSubview(newsImage)
    //Add title label
    let titleLabel = UILabel(frame: CGRect(x: 55, y: 10, width: 100, height: 30))
        titleLabel.font = UIFont.boldSystemFont(ofSize: 21)
        titleLabel.textColor = .white
    if let title = currentArticle.title {
        titleLabel.text = title
    } else {
        titleLabel.text = ""
    }

    myCell.addSubview(titleLabel)
    //Add Author label
    let authorLabel = UILabel(frame: CGRect(x: 10, y: 100, width: 100, height: 20))
        authorLabel.textColor = .white
    if let author = currentArticle.author {
        authorLabel.text = author
    } else {
        authorLabel.text = ""
    }
    
    myCell.addSubview(authorLabel)
    return myCell
}
    
    func applySepialFilter(_ image: UIImage) -> UIImage? {
      guard let data = image.pngData() else { return nil }
      let inputImage = CIImage(data: data)
      let context = CIContext(options: nil)
      guard let filter = CIFilter(name: "CIPhotoEffectMono") else { return nil }
      filter.setValue(inputImage, forKey: kCIInputImageKey)
        
          
      guard
        let outputImage = filter.outputImage,
        let outImage = context.createCGImage(outputImage, from: outputImage.extent)
      else {
        return nil
      }

      return UIImage(cgImage: outImage)
    }
}

*/
