//
//  GroupsStore.swift
//  Lexicon
//
//  Created by mihail on 15.02.2024.
//

import Foundation

final class GroupsStore {
    static let shared = GroupsStore()
    static let groupDidChangeNotification = Notification.Name("groupDidChangeNotification")
    
    private(set) var groups: [Group] = [Group(name: "Dmitriy", color: ._1, cards: []),
                                        Group(name: "Misha", color: ._2, cards: []),
                                        Group(name: "Kirill", color: ._3, cards: []),
                                        Group(name: "valus", color: ._4, cards: []),
                                        Group(name: "Vasua", color: ._5, cards: []),
                                        Group(name: "Nikolay", color: ._6, cards: []),]
    
    func addGroup(group: Group) {
        groups.append(group)
    }
    
    func addWordInGroup(group: Group, card: Card) {
        guard let index = groups.firstIndex(where: { $0.name == group.name }) else { return }
        
        var cards = group.cards
        cards.append(card)
        
        let group = Group(name: group.name, color: group.color, cards: cards)
        groups[index] = group
        
        NotificationCenter.default.post(
            name: GroupsStore.groupDidChangeNotification,
            object: groups,
            userInfo: ["Groups" : groups]
        )
    }
}
