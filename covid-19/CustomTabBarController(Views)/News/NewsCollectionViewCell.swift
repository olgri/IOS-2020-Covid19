import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    // MARK: - Properties
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.layer.borderColor = UIColor.systemRed.cgColor
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 10)
        label.textColor = .white
        label.backgroundColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 16)
        label.textColor = .white
        label.backgroundColor = .systemGray
        label.backgroundColor?.withAlphaComponent(CGFloat(0.45))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
}

// MARK: - UI Setup
extension CollectionViewCell {
    private func setupUI() {
        self.contentView.addSubview(newsImageView)
        newsImageView.addSubview(authorLabel)
        newsImageView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 5),
            newsImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -5),
            newsImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            newsImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
                                    
            titleLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
            titleLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5),
            
            authorLabel.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -10),
            authorLabel.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10),
            authorLabel.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -5)
        ])
        
    }
}
