//
//  OrderSheet.swift
//  PizzaApp
//
//  Created by EDUARDO MEJIA on 28/03/20.
//  Copyright © 2020 EDDIEWARE. All rights reserved.
//

import SwiftUI
import CoreData

struct OrderSheet: View {
    @Environment(\.managedObjectContext) var managedObjectContext //hace una referencia al objeto de base de datos
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedPizzaIndex = 1
    @State private var numberOfSlices = 1
    @State private var tableNumber = ""
    
    let pizzaTypes = ["Pizza Margherita", "Greek Pizza", "Pizza Supreme", "Pizza California", "New York Pizza"]
    var body: some View {
       
        NavigationView{
            Form{
                Section(header: Text("Pizza Details")){
                    Picker("Pizza Type", selection: $selectedPizzaIndex){
                        
                        ForEach(0 ..< pizzaTypes.count)
                        {
                            Text(self.pizzaTypes[$0])
                        }
                        
                    }
                    Stepper("\(numberOfSlices) Slices", value: $numberOfSlices, in: 1...12)
                    
                }
                Section (header: Text("Table"))
                {
                    TextField("Table number", text: $tableNumber)
                        .keyboardType(.numberPad)
                }
                Button("Add Order"){
                    guard self.tableNumber != "" else {return}
                    //Insert del objeto Order
                    let newOrder = Order (context: self.managedObjectContext)
                    newOrder.id = UUID()
                    newOrder.pizzaType = self.pizzaTypes[self.selectedPizzaIndex]
                    newOrder.OrderStatus = .pending
                    newOrder.tableNumber = self.tableNumber
                    newOrder.numberOfSlices = Int16 (self.numberOfSlices)
                    
                    do{
                        try self.managedObjectContext.save()
                        self.presentationMode.wrappedValue.dismiss()
                    }catch{
                        print(error.localizedDescription)
                    }
                }
            }.navigationBarTitle("Add Order")
        }
    }
}

struct OrderSheet_Previews: PreviewProvider {
    static var previews: some View {
        OrderSheet()
    }
}