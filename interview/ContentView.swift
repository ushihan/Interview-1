//
//  ContentView.swift
//  interview
//
//  Created by Shih-Han Hsu on 2021/11/1.
//

import SwiftUI

struct Item: Identifiable {
    var id: Int
    let text: String
    var color: Color
}

struct ContentView: View {
    @State private var itemClicked: Set<Int> = []
    
    let rowCount: Int = 5
    var itemColor: [String : Set<Int>] = [
        "r":[1,2,7,8,12,13,18,19,23,24,29,30,34,35,40,45,46],
        "b":[3,4,9,10,14,15,20,25, 26,31,36,37,41,42,47,48],
        "g":[5,6,11,16,17,21,22,27,28,32,33,38,39,43,44,49]
    ]
    
    var totalRow: Int {
        Int(ceil(Double(items.count) / Double(rowCount)))
    }
    
    
    var items: [Item] {
        var itemsTmp: [Item] = []
        for i in 1...49 {
            var itemTmp = Item(id: i, text: String(format: "%02d", i), color: Color.white)
            if (itemColor["r"]!.contains(i)) {
                itemTmp.color = Color.red
            } else if(itemColor["g"]!.contains(i)) {
                itemTmp.color = Color.green
            } else if(itemColor["b"]!.contains(i)) {
                itemTmp.color = Color.blue
            }
            itemsTmp.append(itemTmp)
        }
        return itemsTmp
    }
    
    func handleClickItem(itemId: Int) {
        if (itemClicked.contains(itemId)) {
            itemClicked.remove(itemId)
        } else {
            itemClicked.insert(itemId)
        }
    }
    
    func getHStack(items: Array<Item>) -> some View {
        return HStack {
            Spacer()
            ForEach(items) { item in
                Button(action: {
                    handleClickItem(itemId: item.id)
                }){
                    Text(String(item.text))
                        .foregroundColor(itemClicked.contains(item.id) ? Color.white : item.color )
                }
                .frame(width: 25, height: 25, alignment: .center)
                .padding()
                .background(itemClicked.contains(item.id) ? item.color.opacity(0.8): item.color.opacity(0.3))
                .clipShape(Capsule())
                Spacer()
            }
            if (items.count % rowCount != 0) {
                ForEach(0 ..< rowCount - items.count) { _ in
                    Spacer().frame(width: 25, height: 25).padding()
                    Spacer()
                }
            }
        }
    }
    
    var body: some View {
        Color.black.edgesIgnoringSafeArea(.all).overlay(
            VStack {
                Spacer()
                ForEach(0 ..< totalRow) { index in
                    let lastOne = (index + 1) * rowCount > items.count ? items.count : (index + 1) * rowCount
                    getHStack(items: Array(items[index * rowCount ..< lastOne]))
                    Spacer()
                }
            }
        )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
