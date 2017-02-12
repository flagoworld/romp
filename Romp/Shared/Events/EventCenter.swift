//
//  EventCenter.swift
//  Romp
//
//  Created by Ryan Layne on 1/29/17.
//  Copyright © 2017 Ryan Layne. All rights reserved.
//

import Foundation

protocol EventSubscriber {

    func handleEvent(_ event: Event)

}

class EventCenter {

    var subscribers = NSHashTable<AnyObject>(options: NSHashTableWeakMemory)
    
    func subscribe(_ subscriber: EventSubscriber) {
    
        subscribers.add(subscriber as AnyObject)
    
    }
    
    func unsubscribe(_ subscriber: EventSubscriber) {
    
        subscribers.remove(subscriber as AnyObject)
    
    }
    
    func send(_ event: Event) {
    
        for subscriber in subscribers.allObjects {
        
            (subscriber as! EventSubscriber).handleEvent(event)
        
        }
    
    }

}
