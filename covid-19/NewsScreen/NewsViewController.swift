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

            DispatchQueue.global().async {
                let newsImage = self.loadImageFromUrl(stringUrl: article.urlToImage) ?? UIImage(named: "no_image")
                DispatchQueue.main.async {
                    cell.newsImageView.image = newsImage
                }
            }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let currentArticle = articles[indexPath.item].url {
        guard let url = URL(string: currentArticle) else { return }
            UIApplication.shared.open(url)}
    }
    
    func loadImageFromUrl(stringUrl: String?) -> UIImage? {
        if let linkToImage = stringUrl {
        if  let url = URL(string: linkToImage){
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) { return image}
            }
        }
        return nil
        }
        else {return nil}
    }
}
// MARK: - UI Setup
extension NewsViewController {
    private func setupUI() {
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
