//
//  PlaceVoteViewController.swift
//
//
//  Created by Ekko on 6/7/24.
//

import UIKit

import CoreKit
import Util

import ReactorKit
import RxCocoa

public final class PlaceVoteViewController: UIViewController, View {
    // MARK: - Properties
    public var disposeBag: DisposeBag = DisposeBag()
    public var coordinator: PlaceVoteCoordinator?
    
    // MARK: - UI Components
    private lazy var placeTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .neutralWhite
        tableView.register(PlaceCell.self, forCellReuseIdentifier: PlaceCell.identifier)
        return tableView
    }()
    
    private lazy var bottomButtonContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .neutralWhite
        view.layer.applySketchShadow(color: .neutral600, alpha: 0.2, x: 0, y: -1, blur: 20, spread: 0)
        return view
    }()

    private lazy var confirmButton: YakGwaButton = {
        let button = YakGwaButton()
        button.title = "투표 완료"
        return button
    }()
    
    // MARK: - Initializers
    public init(reactor: PlaceVoteViewReactor) {
        super.init(nibName: nil, bundle: nil)
        self.reactor = reactor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Life cycles
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .neutral200
        self.setUI()
    }
    // MARK: - Layout
    private func setUI() {
        self.view.addSubview(placeTableView)
        placeTableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        self.view.addSubview(bottomButtonContainer)
        bottomButtonContainer.snp.makeConstraints {
            $0.height.equalTo(92)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        bottomButtonContainer.addSubview(confirmButton)
        confirmButton.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
            $0.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Binding
    public func bind(reactor: PlaceVoteViewReactor) {
        // Action
        self.rx.viewWillAppear
            .map { _ in Reactor.Action.viewWillAppeared }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        placeTableView.rx.modelSelected(MeetVoteInfo.RecommendPlace.self)
            .map { place -> Reactor.Action in
                return Reactor.Action.placeSelected(place.placeId ?? 0)
            }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        confirmButton.rx.tap
            .map { Reactor.Action.completeButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map { $0.places ?? [] }
            .distinctUntilChanged()
            .bind(to: placeTableView.rx.items(cellIdentifier: PlaceCell.identifier, cellType: PlaceCell.self)) { index, place, cell in
                let isSelected = reactor.currentState.selectedPlaces.contains(place.placeId ?? 0)
                cell.configure(place: place, isSelected: isSelected)
            }.disposed(by: disposeBag)
        
        reactor.state
            .map { $0.selectedPlaces }
            .distinctUntilChanged()
            .bind { [weak self] selectedPlaces in
                print("선택된 장소 \(selectedPlaces)")
                self?.placeTableView.reloadData()
            }.disposed(by: disposeBag)
        
        reactor.state
            .map { $0.postVotePlacesResult }
            .distinctUntilChanged()
            .bind { [weak self] result in
                print("포스트 결과 :\(result)")
            }.disposed(by: disposeBag)
        
        reactor.pulse(\.$shouldNavigateToAfterSelectionScene)
            .subscribe(onNext: { [weak self] meetId in
                self?.coordinator?.navigateToAfterVoteScene(meetId: meetId)
            }).disposed(by: disposeBag)
    }
}
