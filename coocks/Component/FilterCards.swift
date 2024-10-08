//
//  FilterCards.swift
//  coocks
//
//  Created by ALINE FERNANDA PONZANI on 03/09/24.
//

import SwiftUI

struct FilterCards: View {
    var name: String
    var tipo: String
    @State private var urlImage: String = ""
    @State private var image: String = ""
    @State private var ids: [String] = []
    @State private var drinkss: [[Drink]] = []
    
    var body: some View {
        NavigationLink(
            destination: ListCocktailsView(listId: ids)
        ) {
            VStack {
                if tipo == "i"{
                    AsyncImage(url: URL(string: "https://www.thecocktaildb.com/images/ingredients/\(name).png")) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 150, height: 150, alignment: .center)
                    }
                } else{
                    let sanitizedCategory = name.replacingOccurrences(of: "/", with: "")
                    Image(sanitizedCategory)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(8)
                }
                Text(name)
                    .foregroundColor(Color("Principal"))
                    .font(.system(size: 16, design: .default))
                    .fontWeight(.regular)
            }
            .scaledToFill()
        }.task {
            await fetchIds()
        }
        .frame(maxHeight: .infinity)
    }
    private func fetchIds() async {
        do {
            let url = "https://www.thecocktaildb.com/api/json/v1/1/filter.php?\(tipo)=\(name)"
            let drinks = try await getTeste(tipo: url)
//            for drink in drinks {
//                let add = try await getDrinkId(id: drink.idDrink)
//                drinkss.append(add)
//            }
            ids = drinks.map { $0.idDrink }
        } catch {
            ids = []
//            print("Erro no FilterCards: \(error)")
        }
    }
}


//struct FilterCards_Previews: PreviewProvider {
//    static var previews: some View {
//        //    urlImage:"https://www.thecocktaildb.com/images/ingredients/gin-Small.png"
//        //    image: "Soft Drink"
//        FilterCards(name: "Testeeeeeeeeee",tipo: "i", urlImage:"https://www.thecocktaildb.com/images/ingredients/gin-Small.png")
//    }
//}
