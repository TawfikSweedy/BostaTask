//
//  PhotosViewController.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage
import SimpleImageViewer

class PhotosViewController: UIViewController, UIScrollViewDelegate , UICollectionViewDelegateFlowLayout , UIGestureRecognizerDelegate, UITextFieldDelegate {
    // MARK: - IBOutlet
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    // MARK: - valriables
    let photosViewModel = PhotosViewModel()
    let disposeBag = DisposeBag()
    var albumTitle = ""
    // MARK: - lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        Binding()
        setupUI()
        getData()
        SubscibeToData()
        SubscribeDataIsEmpty()
        SubscribeLoading()
    }
    // MARK: - Private functions
    func setupUI() {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        searchView.layer.cornerRadius = 10
        searchTextField.delegate = self
        titleLabel.text = albumTitle
        photosCollectionView.RegisterNib(cell: PhotosCollectionViewCell.self)
        photosCollectionView
            .rx.setDelegate(self)
            .disposed(by: disposeBag)
    }
    func Binding() {
        searchTextField.rx.text.orEmpty.bind(to: photosViewModel.searchBehavior).disposed(by: disposeBag)
    }
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if self.searchTextField.text == "" {
            self.photosViewModel.getPhotos()
        }else{
            self.photosViewModel.search()
        }
    }
    func SubscribeDataIsEmpty(){
        photosViewModel.isDataEmpty.subscribe(onNext: { (isEmpty) in
            if !isEmpty {
                self.photosCollectionView.restore()
            }else{
                self.photosCollectionView.setEmptyMessage(bigTitle:"No Data Avaliable", smallTitle: "")
            }
        }).disposed(by: disposeBag)
    }
    func SubscribeLoading(){
        photosViewModel.loadingBehavior.subscribe(onNext: { (isLoading) in
            if isLoading {
                BGLoading.showLoading(self.view)
            }else{
                BGLoading.dismissLoading()
            }
        }).disposed(by: disposeBag)
    }
    func SubscibeToData() {
        photosViewModel.photosModelObservable.bind(to: self.photosCollectionView.rx.items(cellIdentifier: "PhotosCollectionViewCell", cellType: PhotosCollectionViewCell.self)){ row , albumsData , cell in
            let Model = albumsData
            cell.img.sd_setImage(with: URL(string: "\(Model.thumbnailUrl ?? "")"), completed: nil)
            cell.Select = {
                let configuration = ImageViewerConfiguration { config in
                    config.imageView = cell.img
                }
                let imageViewerController = ImageViewerController(configuration: configuration)
                self.present(imageViewerController, animated: true)
            }
        }.disposed(by: disposeBag)
    }
    func SubscribeSearchBtn(){
        searchButton.rx.tap
            .throttle(RxTimeInterval.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self](_) in
                guard self != nil else {return}
                if self?.searchTextField.text == "" {
                    self?.photosViewModel.getPhotos()
                }else{
                    self?.photosViewModel.search()
                }
            }).disposed(by: disposeBag)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let width = collectionView.bounds.width
            let cellWidth = (width ) / 3
            return CGSize(width: cellWidth, height: 140)
        }
    // MARK: - API Services
    func getData() {
        photosViewModel.getPhotos()
    }
}
