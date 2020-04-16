//
//  ContentView.swift
//  PizzaApp
//
//  Created by EDUARDO MEJIA on 28/03/20.
//  Copyright © 2020 EDDIEWARE. All rights reserved.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @State private var showOrderSheet = false
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(
    entity: Order.entity(),
    sortDescriptors:[NSSortDescriptor(key:"tableNumber", ascending: true)],
    predicate: NSPredicate(format: "status != %@", Status.completed.rawValue))
    var  orders: FetchedResults<Order>
    
    var body: some View {
        
        NavigationView{
        List{
            
            
            
        }
        .navigationBarTitle("My Orders")
        .navigationBarItems(
            trailing: Button(action:{
            //onclick
                self.showOrderSheet = true
                
            }, label:{
                        Image(systemName: "plus.circle")
                        .resizable()
                        .frame(width: 32, height: 32, alignment: .center)
            })
        )
            .sheet(isPresented: $showOrderSheet){
                OrderSheet().environment(\.managedObjectContext, self.managedObjectContext)
                
            }
    }
}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
