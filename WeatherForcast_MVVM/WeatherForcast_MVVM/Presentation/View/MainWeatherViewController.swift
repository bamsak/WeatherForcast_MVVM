//
//  MainWeatherViewController.swift
//  WeatherForcast_MVVM
//
//  Created by BOMBSGIE on 4/29/24.
//

import UIKit

final class MainWeatherViewController: UIViewController {
    
    // MARK: - stored Property

    private let mainWeatherViewModel: MainWeatherViewModel
    private lazy var allWeatherDataSource = configureDataSource()
    
    // MARK: - UIComponents
    
    private lazy var weatherCollectionView = UICollectionView(frame: .zero,
                                                              collectionViewLayout: configureCollectionViewLayout()
    ).then {
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    

    // MARK: - Initializer

    init(mainWeatherViewModel: MainWeatherViewModel) {
        self.mainWeatherViewModel = mainWeatherViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setConstratintsCollectionView()
    }
}

// MARK: - Type Alias

private extension MainWeatherViewController {
    typealias HeaderViewRegistration = UICollectionView.SupplementaryRegistration<CurrentWeatherHeaderView>
    typealias CellRegistration = UICollectionView.CellRegistration<WeeklyWeatherCell, Presentation.AllWeather.WeeklyWeatherModel.List>
    typealias AllWeatherDataSource = UICollectionViewDiffableDataSource<Section, Presentation.AllWeather>
}


// MARK: - NestedType

private extension MainWeatherViewController {
    enum Section: Int, CaseIterable {
        case currenWeather
        case weeklyWeather
    }
}

// MARK: - Configure DataSource

private extension MainWeatherViewController {
    func configureDataSource() -> AllWeatherDataSource {
        let headerViewRegistration = configureHeaderViewRegistration()
        let cellRegistration = configureCellRegistration()
        
        let dataSource = AllWeatherDataSource(collectionView: weatherCollectionView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item.weeklyWeather.list[indexPath.row])
        }
        dataSource.supplementaryViewProvider = { collectionView, elementKind, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerViewRegistration, for: indexPath)
        }
        return dataSource
    }
}

// MARK: - Configure Registration

private extension MainWeatherViewController {
    func configureHeaderViewRegistration() -> HeaderViewRegistration {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] supplementaryView, _, indexPath in
            guard let self = self,
                  let item = self.allWeatherDataSource.snapshot().itemIdentifiers(inSection: .currenWeather).last
            else {
                return
            }
            let section = Section(rawValue: indexPath.row)
            if section == .currenWeather {
                supplementaryView.updateUI(with: item.currentWeather)
            }
        }
    }
    
    func configureCellRegistration() -> CellRegistration {
        return .init { cell, indexPath, item in
            let section = Section(rawValue: indexPath.row)
            if section == .weeklyWeather {
                cell.updateUI(item)
            }
        }
    }
}

// MARK: - Auto Layout

private extension MainWeatherViewController {
    func setConstratintsCollectionView() {
        view.addSubview(weatherCollectionView)
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            weatherCollectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            weatherCollectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            weatherCollectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            weatherCollectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

// MARK: - Configure CollectionView

private extension MainWeatherViewController {
    func configureCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        return .init { sectionIndex, layoutEnvironment in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .supplementary
            configuration.backgroundColor = .clear
            
            let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .fractionalHeight(0.15))
            let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, 
                                                                     elementKind: UICollectionView.elementKindSectionHeader,
                                                                     alignment: .top)
            let section = NSCollectionLayoutSection.list(using: configuration,
                                                         layoutEnvironment: layoutEnvironment)
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
}
