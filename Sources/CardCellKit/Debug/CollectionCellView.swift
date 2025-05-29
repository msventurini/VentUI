//
//  DebugView.swift
//  VentUI
//
//  Created by Matheus Silveira Venturini on 18/05/25.
//

import SwiftUI
import UIKit
import Observation
import VentUIDebugKit
import SwiftData
import CocoaAdapterKit


struct DebugView: View {
    @Query(sort: \DebugModel.title) var debugModels: [DebugModel]
    let label: UILabel = {
        let labelView = UILabel()
        
        labelView.text = "aaaaa"
        return labelView
    }()
    
    var body: some View {
        ScrollView {
            VStack {
                
                ForEach(debugModels) { modelItem in
                    
                    Text("a")
                    
                    
                }
            }
        }
        
    }
}

struct TesteEscaping<Content: View>: View {
    
    let content: Content
    
    init(
        _ debugData: Binding<DebugModel?>,
        @ViewBuilder content: @escaping (_ debugData: Binding<DebugModel?>) -> Content
    )  {
        self.content = content(debugData)
        
    }
    var body: some View {
        content
    }
    
}




#Preview(traits: .modifier(PreviewDebugHelper())) {
    //    DebugView()
//    SimpleListViewController(asdasdasd)
    DebugCollectionVCRepresentable()
}

struct DebugCollectionVCRepresentable: UIViewControllerRepresentable {

    @Query(sort: \DebugModel.title) var debugModels: [DebugModel]
    
    func makeUIViewController(context: Context) -> UIViewController {
        let vc = CollectionView_SwiftData_DiffableDatasource_ViewController(container: context.environment.modelContext.container)
        
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
    
    
    typealias UIViewControllerType = UIViewController
    
    
    
}

class CollectionView_SwiftData_DiffableDatasource_ViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, DebugModel>! = nil
    
    var collectionView: UICollectionView! = nil
    
    var container: ModelContainer?
    
    init(container: ModelContainer) {
        self.container = container
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "List"
        configureCollectionView()
        configureDataSource()
    }
    
    private func createLayout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: config)
    }
    
    func configureCollectionView() {
        self.collectionView = .init(frame: .zero, collectionViewLayout: createCollectionViewLayout())
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        collectionView.delegate = self
        //        collectionView.collectionViewLayout =
    }
    
    func createCollectionViewLayout() -> UICollectionViewLayout {
        let recipeItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let recipeItem = NSCollectionLayoutItem(layoutSize: recipeItemSize)
        recipeItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 10.0, bottom: 5.0, trailing: 10.0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.50), heightDimension: .fractionalWidth(0.375))
        
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: recipeItem, count: 2)
        
        
        let section = NSCollectionLayoutSection(group: group)
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureDataSource() {
        
        let cellRegistration = UICollectionView.CellRegistration<CardCell, DebugModel> { (cell, indexPath, item) in
            
            cell.title = item.title
            cell.image = item.image
            
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, DebugModel>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: DebugModel) -> CardCell? in
            
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: identifier)
        }
        
        let descriptor = FetchDescriptor<DebugModel>()
           let users = (try? container?.mainContext.fetch(descriptor)) ?? []

           var snapshot = NSDiffableDataSourceSnapshot<Section, DebugModel>()
           snapshot.appendSections([.main])
           snapshot.appendItems(users)
           dataSource?.apply(snapshot, animatingDifferences: false)
        
    }
}

extension CollectionView_SwiftData_DiffableDatasource_ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}

extension DebugModel : @unchecked Sendable {
    
}
