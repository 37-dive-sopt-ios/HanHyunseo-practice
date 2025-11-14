import UIKit
import SnapKit
// 해야 하는 것: UICollectionView에 셀 등록
// UICollectionView의 delegate, dataSource를 ViewController에게 위임하기
// extension을 통해 해당 프로토콜의 메소드 구현하기
public final class FeedViewController: UIViewController {
    
    // MARK: - Properties
    
    private let lineSpacing: CGFloat = 10 // Layout 구현 흐름상 줄바꿈되는 간격 리턴
    private let itemSpacing: CGFloat = 21 //
    private let cellHeight: CGFloat = 198 // 
    private let collectViewInset: UIEdgeInsets = .init(top: 0, left: 20, bottom: 0, right: 20) // Section당 내부 inset을 리턴
    
    
    // MARK: - UI Components
    // 컬뷰 생성
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = lineSpacing
        layout.minimumInteritemSpacing = itemSpacing
        layout.sectionInset = collectViewInset
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout) // 여기에 layout을 꼭! 넣어줘야 함
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    
    private var feeds: [FeedModel] = []
    
    // MARK: - Lifecycle
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        register()
        setDelegate()
        setLayout()
        loadMockData()
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        view.backgroundColor = .white
        title = "피드"
    }
    
    private func setLayout() {
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func register() {
        collectionView.register(FeedCollectionViewCell.self, forCellWithReuseIdentifier: FeedCollectionViewCell.identifier)
    }
    
    private func setDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // MARK: - Data
    
    private func loadMockData() {
        feeds = FeedModel.mockData
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegate

extension FeedViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("\(feeds[indexPath.item].name) 선택됨")
    }
}

// MARK: - UICollectionViewDataSource

extension FeedViewController: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return feeds.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.identifier, for: indexPath) as? FeedCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(feed: feeds[indexPath.item])
        cell.delegate = self  // Delegate 연결!!!!
        return cell
    }
}


// MARK: - UICollectionViewDelegateFlowLayout

extension FeedViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let horizontalInset: CGFloat = 20
        let width = (collectionView.frame.width - (itemSpacing + horizontalInset * 2)) / 2
        let height: CGFloat = cellHeight
        return CGSize(width: width, height: height)
    }
}

// MARK: - FeedCollectionViewCellDelegate

extension FeedViewController: FeedCollectionViewCellDelegate { // 추가gka
    func didTapScrapButton(_ cell: FeedCollectionViewCell) {
        guard let indexPath = collectionView.indexPath(for: cell) else { return }
        
        // 데이터 업데이트
        feeds[indexPath.item].isScrap.toggle()
        
        // 버튼 상태 변경
        cell.scrapButton.isSelected = feeds[indexPath.item].isScrap
        
        print("\(feeds[indexPath.item].name) 스크랩: \(feeds[indexPath.item].isScrap)")
    }
}
