import SwiftUI

@main
struct MyApp: App {
    
    @State private var showApp = false
    
    var body: some Scene {
        WindowGroup {
            ZStack{
                if showApp {
                    ContentView()
                        .transition(.opacity)
                } else {
                    Image("DuraVita Logo")
                        .resizable()
                        .frame(width:200, height:200)
                        .transition(.scale(scale:2))
                }
            }
            .animation(.easeInOut(duration:0.5), value: showApp)
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    withAnimation {
                        showApp = true
                    }
                }
            }
        }
    }
}
import SwiftUI

class FoodListData: ObservableObject {
    @Published var dairyList: [String] = []
    @Published var fruitList: [String] = []
    @Published var meatList: [String] = []
    @Published var condimentList: [String] = []
    
}
struct ContentView: View {
    @StateObject var foodData = FoodListData()  
    
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("DuraVita")
                    .font(.title)
                
                NavigationLink(destination: ScreenOne().environmentObject(foodData)) {
                    CircleButton(label: "Dairy")
                }
                NavigationLink(destination: ScreenTwo().environmentObject(foodData)) {
                    CircleButton(label: "Fruit/Veggies")
                }
                // Uncomment when ready
                NavigationLink(destination: ScreenThree().environmentObject(foodData)) {
                    CircleButton(label: "Meat")
                }
                NavigationLink(destination: ScreenFour().environmentObject(foodData)) {
                    CircleButton(label: "Condiments")
                }
                
                Spacer()
            }
            .navigationTitle("Select Food Group")
            .padding()
        }
    }
    
    struct CircleButton: View {
        let label: String
        
        var body: some View {
            Text(label)
                .font(.headline)
                .foregroundColor(.green)
                .frame(width: 100, height: 100)
                .background(Color.black)
                .clipShape(Circle())
        }
    }
    
    struct ScreenOne: View {
        @EnvironmentObject var foodData: FoodListData // Access shared data
        @State private var enteredText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Dairy List:")
                    .font(.largeTitle)
                
                // Built-in items
                Text("Butter - 28 Days In Counting")
                Text("Slided Cheese - 10 Days In Counting")
                Text("Yogurt - 11 Days In Counting")
                
                // User-added items with conditional message
                ForEach(foodData.dairyList, id: \.self) { item in
                    if item.lowercased() == "milk" {
                        Text("Milk - 7 Days In Counting")
                    } else {
                        Text(item)
                    }
                }
                
                TextField("Enter Dairy Product", text: $enteredText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250, height: 50)
                
                Button("Add to List") {
                    if !enteredText.isEmpty {
                        foodData.dairyList.append(enteredText)
                        enteredText = ""
                    }
                }
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
        }
    }
    struct ScreenTwo: View {
        @EnvironmentObject var foodData: FoodListData
        @State private var enteredText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Fruit/Veggies List:")
                    .font(.largeTitle)
                
                // Built-in items
                Text("Apples - 28 Days In Counting")
                Text("Carrots - 21 Days In Counting")
                Text("Cucumbers - 7 Days In Counting")
                
                // User-added items with special message
                ForEach(foodData.fruitList, id: \.self) { item in
                    if item.lowercased() == "strawberries" {
                        Text("strawberries - 4 Days In Counting")
                            .foregroundColor(.purple)
                    } else {
                        Text(item)
                    }
                }
                
                TextField("Enter Fruit/Veggie Product", text: $enteredText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                Button("Add to List") {
                    if !enteredText.isEmpty {
                        foodData.fruitList.append(enteredText)
                        enteredText = ""
                    }
                }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
        }
    }
    
    struct ScreenThree: View {
        @EnvironmentObject var foodData: FoodListData
        @State private var enteredText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Meat List:")
                    .font(.largeTitle)
                
                Text("Ground Beef - 4 Days In Counting")
                Text("Bacon - 7 Days In Counting")
                Text("Deli Meat - 4 Days In Counting")
                
                ForEach(foodData.meatList, id: \.self) { item in
                    if item.lowercased() == "bacon" {
                        HStack {
                            Text(item)
                            Text(" - 7 Days In Counting")
                                .foregroundColor(.orange)
                        }
                    } else {
                        Text(item)
                    }
                }
                
                
                TextField("Enter Meat Product", text: $enteredText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                Button("Add to List") {
                    if !enteredText.isEmpty {
                        foodData.meatList.append(enteredText)
                        enteredText = ""
                    }
                }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
        }
    }
    struct ScreenFour: View {
        @EnvironmentObject var foodData: FoodListData
        @State private var enteredText = ""
        
        var body: some View {
            VStack(spacing: 20) {
                Text("Condiments List:")
                    .font(.largeTitle)
                
                Text("Ketchup - 180 Days In Counting")
                Text("Mustard - 360 Days In Counting")
                Text("Pesto - 7 Days In Counting")
                
                ForEach(foodData.condimentList, id: \.self) { item in
                    if item.lowercased() == "ketchup" {
                        HStack {
                            Text(item)
                            Text(" - 180 Days In Counting")
                                .foregroundColor(.green)
                        }
                    } else {
                        Text(item)
                    }
                }
                
                
                TextField("Enter Condiment Product", text: $enteredText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .frame(width: 250)
                
                Button("Add to List") {
                    if !enteredText.isEmpty {
                        foodData.condimentList.append(enteredText)
                        enteredText = ""
                    }
                }
                .padding()
                .background(Color.orange)
                .foregroundColor(.white)
                .cornerRadius(8)
                
                Spacer()
            }
            .padding()
        }
    }
}




