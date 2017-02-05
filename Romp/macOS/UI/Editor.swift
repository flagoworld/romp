//
//  Editor.swift
//  Romp
//
//  Created by Ryan Layne on 2/3/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Cocoa


protocol EditorUIDelegate {

    func editorUIObjectDefinitions() -> [AnyObject]
    func editorUIActiveObjectDefinition() -> AnyObject?
    func editorUIActiveObjectDefinitionChanged(activeObjectDefinition: AnyObject?)

}

class Editor: UserInterface, NSCollectionViewDelegate, NSCollectionViewDataSource {
    
    @IBOutlet weak var objectsCollectionView: NSCollectionView?
    
    var delegate: EditorUIDelegate? = nil
    
    override func awakeFromNib() {
        
        if let objectsCollectionView = self.objectsCollectionView {
        
            let flowLayout = NSCollectionViewFlowLayout()
            flowLayout.itemSize = NSSize(width: objectsCollectionView.bounds.size.width - 20.0, height: 40.0)
            flowLayout.sectionInset = EdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
            flowLayout.minimumInteritemSpacing = 20.0
            flowLayout.minimumLineSpacing = 20.0
            
            objectsCollectionView.collectionViewLayout = flowLayout
        }
    
    }
    
    
    // MARK: NSCollectionView
    
    func numberOfSections(in collectionView: NSCollectionView) -> Int {
        
        return 1
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let delegate = self.delegate {
        
            return delegate.editorUIObjectDefinitions().count
        
        } else {
        
            return 0
        
        }
        
    }
    
    func collectionView(_ collectionView: NSCollectionView, itemForRepresentedObjectAt indexPath: IndexPath) -> NSCollectionViewItem {
    
        let item = collectionView.makeItem(withIdentifier: "ObjectCollectionViewItem", for: indexPath)
        guard let collectionViewItem = item as? ObjectCollectionViewItem else { return item }
        
        
        collectionViewItem.imageView?.image = NSImage.init(named: "grass.png")
        collectionViewItem.textField?.stringValue = "Object at: \(indexPath.item)"
        
        
        return item
    
    }
    
    func collectionView(_ collectionView: NSCollectionView, didSelectItemsAt indexPaths: Set<IndexPath>) {
        
        if let delegate = self.delegate {
        
            delegate.editorUIActiveObjectDefinitionChanged(activeObjectDefinition: delegate.editorUIObjectDefinitions()[indexPaths.first!.item])
            
        }
        
    }

}
