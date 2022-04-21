//
//  PhotosViewModel.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import PromiseKit

class PhotosViewModel {
    // MARK: - Public variables
    var searchBehavior         = BehaviorRelay<String>(value : "")
    var loadingBehavior        = BehaviorRelay<Bool>(value: false)
    var isDataEmpty            = BehaviorRelay<Bool>(value: false)
    var searchArray            = [PhotosModel]()
    var photosModelObservable  : Observable<[PhotosModel]> {
        return PhotosModelSubject
    }
    // MARK: - private valriables
    private var PhotosModelSubject  = PublishSubject<[PhotosModel]>()
    private let photosServices       = MoyaProvider<Services>()
    // MARK: - Private functions
    func search() {
        let dataSearch = searchArray.filter({ $0.title?.contains(searchBehavior.value) == true })
        PhotosModelSubject.onNext(dataSearch)
    }
    // MARK: - API Services
    func getPhotos(){
        firstly { () -> Promise<Any> in
            loadingBehavior.accept(true)
            return BGServicesManager.CallApi(self.photosServices,Services.Photos)
        }.done({ [self] response in
            let result = response as! Response
            let data : [PhotosModel] = try BGDecoder.decode(data: result.data)
            self.searchArray = data
            if data.count > 0 {
                self.PhotosModelSubject.onNext(data)
                self.isDataEmpty.accept(false)
            }else{
                self.isDataEmpty.accept(true)
            }
        }).ensure {
            self.loadingBehavior.accept(false)
        }.catch { (error) in
            BGAlertPresenter.displayToast(title: "" , message: "\(error)", type: .error)
        }
    }
}
