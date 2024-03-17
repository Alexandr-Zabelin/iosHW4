//
//  CalendarEventManager.swift
//  aszabelinPW2
//
//  Created by Забелин Александр Сергеевич on 17.03.2024.
//

import EventKit

protocol CalendarManaging {
    func create(eventModel: WishEventModel) -> Bool
}

final class CalendarManager: CalendarManaging {
    enum Constants {
        static var errorMesage: String = "failed to save event"
    }
    
    private let eventStore : EKEventStore = EKEventStore()
    
    func create(eventModel: WishEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        group.enter()
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        group.wait()
        return result
    }
    
    func create(eventModel: WishEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted,
                                                                                     error) in
            guard granted, error == nil, let self else {
                completion?(false)
                return
            }
            
            let event: EKEvent = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.notes = eventModel.description
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do {
                try self.eventStore.save(event, span: .thisEvent)
            } catch _ {
                print(Constants.errorMesage)
                completion?(false)
            }
            completion?(true)
        }
        
        eventStore.requestAccess(to: .event, completion: createEvent)
    }
}
