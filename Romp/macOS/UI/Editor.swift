//
//  Editor.swift
//  Romp
//
//  Created by Ryan Layne on 2/3/17.
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Cocoa
import GameplayKit


protocol EditorUIDelegate {

    // Editing
    func editorUIEditingModeChanged(editingMode: EditingMode)
    
    // Adding
    func editorUIResources() -> [Resource]
    func editorUIActiveResource() -> Resource?
    func editorUIActiveResourceChanged(activeResource: Resource?)

}

class Editor: UserInterface, NSCollectionViewDelegate, NSCollectionViewDataSource, NSTabViewDelegate {
    
    @IBOutlet weak var objectsCollectionView: NSCollectionView?
    
    @IBOutlet weak var editImageView: NSImageView?
    @IBOutlet weak var editName: NSTextField?
    @IBOutlet weak var editPhysics: NSPopUpButton?
    @IBOutlet weak var editShader: NSPopUpButton?
    
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
    
    func setSelectedEntity(_ entity: GKEntity?) {
    
        if let entity = entity {
        
            if let resource = (entity as? MapObject)?.resource {
            
                editImageView!.image = NSImage(named: resource.texture)
                editName!.stringValue = resource.name
                
                switch resource.physics {
                
                case .none:
                    editPhysics!.selectItem(at: 0)
                
                case .fixed:
                    editPhysics!.selectItem(at: 1)
                
                case .dynamic:
                    editPhysics!.selectItem(at: 2)
                
                }
                
                editShader?.selectItem(at: 0)
            
            } else {
            
                editImageView!.image = nil
                editName!.stringValue = "Unknown Entity"
                editPhysics!.selectItem(at: 0)
                editShader?.selectItem(at: 0)
            
            }
            
            editPhysics?.isEnabled = true
            editShader?.isEnabled = true
        
        } else {
        
            editImageView!.image = nil
            editName!.stringValue = "No Selection"
            editPhysics!.selectItem(at: 0)
            editShader?.selectItem(at: 0)
            
            editPhysics?.isEnabled = false
            editShader?.isEnabled = false
        
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
    
    func collectionView(_ collectionView: NSCollectionView, didDeselectItemsAt indexPaths: Set<IndexPath>) {
     
        if let delegate = self.delegate {
        
            delegate.editorUIActiveResourceChanged(activeResource: nil)
            
        }
        
    }
    
    
    // MARK: NSTabView
    
    func tabView(_ tabView: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
    
        if tabView.indexOfTabViewItem(tabViewItem!) == 1 {
        
            delegate?.editorUIEditingModeChanged(editingMode: ( .add ))
            
        } else {
            
            delegate?.editorUIEditingModeChanged(editingMode: ( .edit ))
            
        }
        
    }

}
