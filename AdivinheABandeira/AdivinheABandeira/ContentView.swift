//
//  ContentView.swift
//  AdivinheABandeira
//
//  Created by Fábio Carlos de Souza on 29/12/22.
//

import SwiftUI

struct ContentView: View {
    @State private var mostrarResultado = false
    @State private var tituloResultado = ""
    
    @State private var paises = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA"].shuffled()
    
    @State private var respostaCorreta = Int.random(in: 0...2)
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: .purple, location: 0.3), .init(color: .black, location: 0.3)], center: .top, startRadius: 300, endRadius: 700)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("Advinhe a bandeira")
                    .font(.largeTitle.weight(.bold))
                    .foregroundColor(.black)
                VStack(spacing: 15) {
                    VStack {
                        Text("Selecione a bandeira da")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(paises[respostaCorreta].uppercased())
                            .foregroundColor(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    ForEach(0..<3) { number in
                        Button {
                            tocouNaBandeira(number)
                        } label: {
                            Image(paises[number].lowercased())
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                Spacer()
                Spacer()
                Text("Placar: ??")
                    .foregroundColor(.purple)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
          
        }
        .alert(tituloResultado, isPresented: $mostrarResultado) {
            Button("Próximo", action: perguntar)
        } message: {
            Text("Seu resultado é ???")
        }
    }
    func tocouNaBandeira(_ number: Int) {
        if number == respostaCorreta {
            tituloResultado = "Acertou"
        } else {
            tituloResultado = "Errou"
        }
        mostrarResultado = true
    }
    
    func perguntar() {
        paises.shuffle()
        respostaCorreta = Int.random(in: 0...2)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
