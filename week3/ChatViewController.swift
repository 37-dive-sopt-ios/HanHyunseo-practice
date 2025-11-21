//
//  ChatViewController.swift
//  week3
//
//  Created by 한현서 on 11/21/25.
//

import Foundation
import UIKit
import SnapKit

final class ChatViewController: UIViewController {
    
    // MARK: - UI Components
    
    private let tableView = UITableView(frame: .zero, style: .plain) // 테이블 뷰 객체 초기화
    
    // MARK: - Properties
    
    private var chatRooms: [ChatRoomModel] = [] // 배열 초기화
    
    // MARK: - Init
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        register()
        setDelegate()
        setLayout()
        loadMockData() // 데이터 불러오기
    }
    
    // MARK: - UI Setup
    // 기본 속성 정의
    private func setUI() {
        view.backgroundColor = .white
        title = "채팅"
        tableView.separatorStyle = .singleLine
    }
    
    // 레이아웃 잡기
    private func setLayout() {
        self.view.addSubview(tableView)
        
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 셀 등록
    private func register() {
        tableView.register(ChatTableViewCell.self, forCellReuseIdentifier: ChatTableViewCell.identifier)
    }
    
    // 누구한테 위임할건지 채택
    private func setDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // MARK: - Data
    
    private func loadMockData() {
        chatRooms = ChatRoomModel.mockData
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(chatRooms[indexPath.row].name) 채팅방 선택됨")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
}

// MARK: - UITableViewDataSource

extension ChatViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ChatTableViewCell.identifier, for: indexPath) as? ChatTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(chatRoom: chatRooms[indexPath.row]) // 인덱스 바인딩
        return cell
    }
}
