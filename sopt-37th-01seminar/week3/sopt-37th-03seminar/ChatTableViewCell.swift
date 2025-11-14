import UIKit
import SnapKit
// TableView에 데이터를 넣고 표시하기 위해서는 각 행을 표시해주는 UITableViewCell이 필요합니다!!
// 공식문서: 테이블행의 내용을 관리하도록 도와주는 특수한 유형의 View
final class ChatTableViewCell: UITableViewCell {
    
    static let identifier: String = "ChatTableViewCell" // 셀에 식별자 생성하기. 각 셀을 구분할 수 있는 식별자 필요. 전역 변수 identifier를 통해서 해당 셀을 구분
    
    // MARK: - UI Components
    // 셀 안에 들어가는 UIComponent들
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        label.numberOfLines = 1
        return label
    }()
    
    private let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 4
        imageView.backgroundColor = .systemGray6
        return imageView
    }()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setHierarchy()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI & Layout
    
    private func setUI() {
        selectionStyle = .none
        backgroundColor = .white
    }
    
    private func setHierarchy() {
        contentView.addSubviews(
            profileImageView,
            nameLabel,
            locationLabel,
            messageLabel,
            thumbnailImageView
        )
    }
    
    private func setLayout() {
        profileImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.top).offset(0.5)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(nameLabel)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(nameLabel.snp.bottom).offset(6)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(16)
            $0.trailing.equalTo(thumbnailImageView.snp.leading).offset(-8)
        }
        
        thumbnailImageView.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(20)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(40)
        }
    }
    
    // MARK: - Configuration
    // ChatRoomModel이라는 데이터 덩어리를 받아서 그 안에 있는 정보를 화면의 실제 요소에 하나씩 연결
    func configure(chatRoom: ChatRoomModel) {
        profileImageView.image = chatRoom.profileImage
        nameLabel.text = chatRoom.name
        locationLabel.text = chatRoom.location
        messageLabel.text = chatRoom.lastMessage
        thumbnailImageView.image = chatRoom.thumbnail
    }
}
