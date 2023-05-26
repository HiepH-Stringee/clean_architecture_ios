//
//  ListContactPresenter.swift
//  CleanVIPER
//
//  Created by Hiệp Hoàng on 26/05/2023.
//

import Foundation

class ListContactPresenter: ListContactPresenterProtocol {

    
    var view: ListContactViewProtocol?
    
    var interactor: ListContactInteractorInputProtocol?
    
    var router: ListContactRouteProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.refresh()
    }
    
    func showContactDetail(_ contact: Contact) {
        router?.presentContactDetail(from: view!, forContact: contact)
    }
    
    func refresh() {
        interactor?.refresh()
    }
    
    func loadMore() {
        view?.showLoading()
        interactor?.loadMore()
    }
}

extension ListContactPresenter: ListContactInteractorOutputProtocol {
    
    func didRetriveContacts(_ contacts: [Contact]) {
        view?.hideLoading()
        view?.hideFetching()
        view?.showContacts(contacts)
    }
    
    func onError(_ error: Error) {
        print(error.localizedDescription)
    }
    
}
