//
//  ContentView.swift
//  Shared
//
//  Created by Amad Walid on 2022-04-25.
//

import SwiftUI
import Combine

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(viewModel.businesses, id: \.id) { business in
                    NavigationLink(destination: BusinessDetailView(name: business.name ?? "")) {
                        let rating = String(format: "%.1f", business.rating ?? 0.0)
                        LazyHStack {
                            AsyncImage(url: URL(string: business.imageURL ?? "")) { image in
                                image.resizable()
                            } placeholder: {
                                Color.red
                            }
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding()
                                
                            LazyVStack (alignment: .leading) {
                                Text("\(business.name ?? "No name")")
                                Text("\(business.price ?? "")")
                                Text("\(rating) \(Image(systemName: "star"))")
                            }
                        }
                    }
                }
            }

            .listStyle(.plain)
            .navigationTitle(Text("Stockholm"))
            .onAppear(perform: viewModel.search)
            //.searchable(text: .constant(""))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

struct BusinessDetailView: View {
    let name: String

    var body: some View {
        Text("\(name)")
            .font(.largeTitle)
    }
}
