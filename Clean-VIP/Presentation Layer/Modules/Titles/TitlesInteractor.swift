//
//  TitlesInteractor.swift
//  Clean-VIP
//
//  Created by Zafar on 5/26/20.
//  Copyright © 2020 Zafar. All rights reserved.
//

import Foundation

protocol TitlesInteractor: class {
    var presenter: TitlesPresenter? { get }
    
    func viewDidLoad()
    func addTapped(with text: String)
    
    func didSelectRow(at index: Int)
}

class TitlesInteractorImplementation: TitlesInteractor {
    var presenter: TitlesPresenter?
    
    private let titlesService = TitlesServiceImplementation()
    private var titles: [Title] = []
    
    func viewDidLoad()  {
        do {
            self.titles = try titlesService.getTitles()
            
            presenter?.interactor(didRetrieveTitles: self.titles)
        } catch {
            presenter?.interactor(didFailRetrieveTitles: error)
        }
    }
    
    func addTapped(with text: String) {
        do {
            let title = try titlesService.addTitle(text: text)
            self.titles.append(title)
            
            presenter?.interactor(didAddTitle: title)
        } catch {
            presenter?.interactor(didFailAddTitle: error)
        }
    }
    
    func didSelectRow(at index: Int) {
        if self.titles.indices.contains(index) {
            presenter?.interactor(didFindTitle: self.titles[index])
        }
    }
}
