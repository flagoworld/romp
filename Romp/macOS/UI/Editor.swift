//
//  Editor.swift
//  Romp
//
//  Created by Ryan Layne on 2/3/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Cocoa


protocol EditorUIDelegate {

    func editorUIResources() -> [Resource]
    func editorUIActiveResource() -> Resource?
    func editorUIActiveResourceChanged(activeResource: Resource?)

}

class Editor: UserInterface, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    @IBOutlet weak var objectsCollectionView: NSCollectionView?
    
    var delegate: EditorUIDelegate? = nil
    
    override func awakeFromNib() {
        
        if let objectsCollectionView = self.objectsCollectionView {
        
            let flowLayout = NSCollectionViewFlowLayout()
            flowLayout.itemSize = NSSize(width: objectsCollectionView.bounds.size.width - 10.0, height: 40.0)
            flowLayout.sectionInset = EdgeInsets(top: 5.0, left: 5.0, bottom: 5.0, right: 5.0)
            flowLayout.minimumInteritemSpacing = 10.0
            flowLayout.minimumLineSpacing = 10.0
            
            objectsCollectionView.collectionViewLayout = flowLayout
        }
    
    }
    
    
    // MARK: NSCollectionView
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let delegate = self.delegate {
        
            return delegate.editorUIResources().count
        
        } else {
        
            return 0
        
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    
        let item = collectionView.makeItem(withIdentifier: "ObjectCollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? ObjectCollectionViewItem else { return item }
        let resource = delegate!.editorUIResources()[indexPath.item]
        
        collectionViewItem.imageView?.image = NSImage.init(named: resource.texture)
        collectionViewItem.textField?.stringValue = resource.name
        
        
        return item
    
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        if let delegate = self.delegate {
        
            delegate.editorUIActiveResourceChanged(activeResource: delegate.editorUIResources()[indexPaths.first!.item])
            
        }
        
    }

}
