//
//  ContactViewModel.swift
//  CleanMVVM
//
//  Created by Hiệp Hoàng on 25/05/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct ContactViewModel: ViewModelType {

    var repo: ContactRepository
    var route: ContactRoute
    
    init(repo: ContactRepository, route: ContactRoute) {
        self.repo = repo
        self.route = route
    }
    
    struct Input {
        let refresh: Driver<Void>
        let selection: Driver<IndexPath>
        let loadMore: Driver<Void>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let loading: Driver<Bool>
        let contacts: Driver<[Contact]>
        let toDetail: Driver<Void>
    }
    
    func transform(input: Input) -> Output {
        let activity = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let refreshContact = input.refresh.flatMapLatest { _ in
            return repo.refresh()
                .trackActivity(activity)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let loadingActivity = ActivityIndicator()
        
        let loadMoreContact = input.loadMore.flatMapLatest { _ in
            repo.nextPage()
                .trackActivity(loadingActivity)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        let contacts = Driver.merge(refreshContact, loadMoreContact)
        
        let toDetail = input.selection.do(onNext: { self.route.goToDetail(repo.itemAtIndex($0.row)!)}).mapToVoid().asDriver()
                
        let fetching = activity.asDriver()
        
        return Output(fetching: fetching, loading: loadingActivity.asDriver(), contacts: contacts, toDetail: toDetail)
    }
}
