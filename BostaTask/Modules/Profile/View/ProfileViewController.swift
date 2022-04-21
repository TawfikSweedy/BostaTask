//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import UIKit
import RxSwift
import RxCocoa

class ProfileViewController: UIViewController, UIScrollViewDelegate {
    // MARK: - IBOutlet
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userAddressLabel: UILabel!
    @IBOutlet weak var albumsTableView: UITableView!
    // MARK: - valriables
    let profileViewModel = ProfileViewModel()
    let disposeBag = DisposeBag()
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        getData()
        SubscibeToData()
        SubscribeToSelect()
        SubscribeDataIsEmpty()
        SubscribeLoading()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
    // MARK: - Private functions
    func setupUI() {
        albumsTableView.RegisterNib(cell: MyAlbumsTableViewCell.self)
        albumsTableView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    func SubscribeDataIsEmpty(){
        profileViewModel.isDataEmpty.subscribe(onNext: { (isEmpty) in
            if !isEmpty {
                self.albumsTableView.restore()
            }else{
                self.albumsTableView.setEmptyMessage(bigTitle:"No Data Avaliable", smallTitle: "")
            }
        }).disposed(by: disposeBag)
    }
    func SubscribeLoading(){
        profileViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                BGLoading.showLoading(self.view)
            }else{
                BGLoading.dismissLoading()
            }
        }).disposed(by: disposeBag)
    }
    func SubscibeToData() {
        profileViewModel.userNameObservable.bind { userName in
            self.userNameLabel.text = userName
        }.disposed(by: disposeBag)
        profileViewModel.userAddressObservable.bind { userAddress in
            self.userAddressLabel.text = userAddress
        }.disposed(by: disposeBag)
        profileViewModel.albumsModelObservable.bind(to: self.albumsTableView.rx.items(cellIdentifier: "MyAlbumsTableViewCell", cellType: MyAlbumsTableViewCell.self)){ row , albumsData , cell in
            let Model = albumsData
            cell.albumNameLabel.text = Model.title
        }.disposed(by: disposeBag)
    }
    func SubscribeToSelect() {
        Observable.zip(albumsTableView.rx.itemSelected,albumsTableView.rx.modelSelected(AlbumsModel.self)).bind{ [weak self] selectedIndex , data in
            let storyboard = UIStoryboard(name: "Main" , bundle: nil)
            let vc  = storyboard.instantiateViewController(withIdentifier: "PhotosViewController") as! PhotosViewController
            vc.albumTitle = data.title ?? ""
            vc.modalPresentationStyle = .fullScreen
            self?.navigationController?.pushViewController(vc, animated: true)
            self?.albumsTableView.deselectRow(at: selectedIndex , animated: true)
        }.disposed(by: disposeBag)
    }
    // MARK: - API Services
    func getData() {
        profileViewModel.getUsers()
        profileViewModel.getAlbums()
    }
}
