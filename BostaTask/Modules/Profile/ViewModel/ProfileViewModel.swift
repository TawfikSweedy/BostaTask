//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by Tawfik Sweedy✌️ on 4/20/22.
//

import Foundation
import RxCocoa
import RxSwift
import Moya
import PromiseKit

class ProfileViewModel {
    // MARK: - Public variables
    var loadingBehavior        = BehaviorRelay<Bool>(value: false)
    var isDataEmpty            = BehaviorRelay<Bool>(value: false)
    var albumsModelObservable   : Observable<[AlbumsModel]> {
        return AlbumsModelSubject
    }
    var userNameObservable   : Observable<String> {
        return UserNameSubject
    }
    var userAddressObservable   : Observable<String> {
        return UserAddressSubject
    }
    // MARK: - private valriables
    private var AlbumsModelSubject  = PublishSubject<[AlbumsModel]>()
    private var UserNameSubject     = PublishSubject<String>()
    private var UserAddressSubject  = PublishSubject<String>()
    private let usersServices       = MoyaProvider<Services>()
    private let albumsServices      = MoyaProvider<Services>()
    // MARK: - API Services
    func getUsers(){
        firstly { () -> Promise<Any> in
            loadingBehavior.accept(true)
            return BGServicesManager.CallApi(self.usersServices,Services.Users)
        }.done({ [self] response in
            let result = response as! Response
            let data : [UsersModel] = try BGDecoder.decode(data: result.data)
            self.UserNameSubject.onNext(data[0].name ?? "")
            self.UserAddressSubject.onNext("\(data[0].address?.street ?? "") , \(data[0].address?.suite ?? "") , \(data[0].address?.city ?? "") , \(data[0].address?.zipcode ?? "")")
        }).ensure {
            self.loadingBehavior.accept(false)
        }.catch { (error) in
            BGAlertPresenter.displayToast(title: "" , message: "\(error)", type: .error)
        }
    }
    func getAlbums(){
        firstly { () -> Promise<Any> in
            loadingBehavior.accept(true)
            return BGServicesManager.CallApi(self.albumsServices,Services.Albums)
        }.done({ [self] response in
            let result = response as! Response
            let data : [AlbumsModel] = try BGDecoder.decode(data: result.data)
            if data.count > 0 {
                self.AlbumsModelSubject.onNext(data)
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
