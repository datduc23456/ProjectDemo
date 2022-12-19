import UIKit

class GenresSearchTableViewCell: UITableViewCell, BaseWithCollectionTableViewCellHandler {
    var collectionView: BaseCollectionView!
    
    @IBOutlet weak var genresCollectionView: UICollectionView!
    var listPayload: [Any] = []
    
    var didTapActionInCell: ((Any) -> Void) = {_ in}
    
    var payload: [Genre] = [] {
        didSet {
            genresCollectionView.reloadData()
        }
    }
    
    var collectionViewOffset: CGFloat {
        get {
            return genresCollectionView.contentOffset.x
        }
        
        set {
            genresCollectionView.contentOffset.x = newValue
        }
    }
    
    func initCollectionViewCell() {
        genresCollectionView.dataSource = self
        genresCollectionView.delegate = self
        genresCollectionView.collectionViewLayout.invalidateLayout()
        genresCollectionView.reloadData()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
        genresCollectionView.registerCell(for: GengesCollectionViewCell.className)
        let collectionViewFlowLayout = CollectionViewFlowLayout()
        collectionViewFlowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        collectionViewFlowLayout.minimumLineSpacing = 8
        collectionViewFlowLayout.headerReferenceSize = CGSize(width: 16, height: 1)
        collectionViewFlowLayout.scrollDirection = .vertical
        genresCollectionView.collectionViewLayout = collectionViewFlowLayout
        initCollectionViewCell()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}

extension GenresSearchTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DTPBusiness.shared.listGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GengesCollectionViewCell.className, for: indexPath)  as? GengesCollectionViewCell else {
            return UICollectionViewCell()
        }
        let genre = DTPBusiness.shared.listGenres[indexPath.row]
        cell.configCell(genre)
        cell.viewBackgroundImage.backgroundColor = .black
        cell.image.tintColor = .white
        cell.lbTitle.textColor = .white
        cell.didTapAction = { [weak self] any in
            guard let `self` = self else { return }
            self.didTapActionInCell(any)
        }
        cell.contentView.backgroundColor = CHOOSE_GENRE_COLOR
        return cell
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        self.collectionView.layoutIfNeeded()
        self.layoutIfNeeded()
        let contentSize = self.collectionView.collectionViewLayout.collectionViewContentSize
        return CGSize.init(width: contentSize.width, height: contentSize.height)
    }
}
