//
//  CharacterListVC.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import UIKit
import SwiftUI
import Combine

class CharacterListVC: UIViewController {
    
    //MARK: private variables
    private let viewModel = CharactersViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    //MARK: Outlets
    
    @IBOutlet weak var collectionview: UICollectionView!
    
    //MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupBindings()
        viewModel.loadCharacters()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupEnlargedNavigation(title: "Characters")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.setupTransparentNavigationBar()
    }
    
}

//MARK: Private Methods
extension CharacterListVC {
    private func setupBindings() {
        viewModel.$characters
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.collectionview.reloadData()
            }
            .store(in: &cancellables)
    }
}

//MARK: CollectionView Delegate

extension CharacterListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0{
            return viewModel.filterStatus.count
        }
        return viewModel.characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section{
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FilterCollectionViewCell.ID, for: indexPath) as? FilterCollectionViewCell else { return UICollectionViewCell() }
            cell.bind(text: viewModel.filterStatus[indexPath.item])
            return cell
        case 1:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterCollectionViewCell.ID, for: indexPath) as? CharacterCollectionViewCell else { return UICollectionViewCell() }
            let characterItem = viewModel.characters[indexPath.item]
            cell.bind(model: characterItem)
            viewModel.loadMoreIfNeeded(currentItem: characterItem)
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        switch indexPath.section {
        case 0:
            viewModel.filterCharacters(at: indexPath.item)
        default:
            let character = viewModel.characters[indexPath.item]
            let detailView = CharacterDetailView(character: character)
            let hostingController = UIHostingController(rootView: detailView)
            navigationController?.pushViewController(hostingController, animated: true)
        }
    }
    
}

//MARK: Private Methods

extension CharacterListVC {
    func setupCollectionView() {
        collectionview.delegate = self
        collectionview.dataSource = self
        
        let characterNib = UINib(nibName: CharacterCollectionViewCell.ID, bundle: nil)
        collectionview.register(characterNib, forCellWithReuseIdentifier: CharacterCollectionViewCell.ID)
        
        let filterNib = UINib(nibName: FilterCollectionViewCell.ID, bundle: nil)
        collectionview.register(filterNib, forCellWithReuseIdentifier: FilterCollectionViewCell.ID)
        
        let layout = UICollectionViewCompositionalLayout { sectionIndex, environment in
            return sectionIndex == 0 ? self.buildHorizontalSectionLayout() : self.buildVerticalLayout()
        }
        collectionview.collectionViewLayout = layout
    }
  
    private func buildHorizontalSectionLayout(firstSectionHeight: CGFloat = 50) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(80),
                heightDimension: .fractionalHeight(1.0)
            )
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0.0, leading: 4.0, bottom: 0.0, trailing: 4.0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .estimated(80),
                heightDimension: .absolute(firstSectionHeight)
            ),
            subitems: [item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 11, bottom: 5, trailing: 11)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        
        return section
    }
    
    private func buildVerticalLayout() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70)))
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(70))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 1)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        
        return section
    }
}
