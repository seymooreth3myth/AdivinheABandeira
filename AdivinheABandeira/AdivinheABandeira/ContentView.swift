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
    @State private var resultado = 0
    @State private var tentativas = 0
    @State private var animationAmount = 0.0
    
    @State private var paises = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Russia", "Spain", "UK", "USA"].shuffled()
    
    @State private var respostaCorreta = Int.random(in: 0...2)
    @State private var selectedFlagIndex: Int?
    @State private var touchedOpacity = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [.init(color: .purple, location: 0.3), .init(color: .black, location: 0.3)], center: .top, startRadius: 300, endRadius: 700)
                .ignoresSafeArea()
            if tentativas < 8 {
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
                        ForEach(Array(paises.prefix(3).enumerated()), id: \.offset) { index, pais in
                            Button {
                                touchedOpacity = true
                                self.selectedFlagIndex = index
                                withAnimation(.easeInOut) {
                                    animationAmount += 360
                                }
                               
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                    tocouNaBandeira(index)
                                    self.selectedFlagIndex = nil
                                    touchedOpacity = false
                                }
                                
                            } label: {
                                Image(pais.lowercased())
                                    .renderingMode(.original)
                                    .clipShape(Capsule())
                                    .shadow(radius: 5)
                                   
                                    .rotation3DEffect(
                                        self.selectedFlagIndex == index ? .degrees(animationAmount) : .degrees(0), axis: (x: 0    , y: 1, z: 0))
                                
                            }
                            .opacity(touchedOpacity ? self.selectedFlagIndex == index ? 1.0 : 0.25 : 1.0)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    Spacer()
                    Text("Placar: \(resultado)")
                        .foregroundColor(.purple)
                        .font(.title.bold())
                    Spacer()
                }
                .padding()
            } else {
                VStack {
                    Spacer()
                    Text("Advinhe a bandeira")
                        .font(.largeTitle.weight(.bold))
                        .foregroundColor(.black)
                    VStack(spacing: 15) {
                        VStack {
                          
                            Text("Resultado")
                                .foregroundColor(.white)
                                .font(.largeTitle.weight(.semibold))
                            Text("Placar: \(resultado)")
                                .foregroundColor(.white)
                                .font(.largeTitle.weight(.semibold))
                        }
                        Button("Jogar novamente") {
                            tentativas = 0
                            resultado = 0
                            tituloResultado = ""
                            mostrarResultado = false
                        }
                        .buttonStyle(.bordered)
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 20)
                    .background(.ultraThinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    Spacer()
                    Spacer()

                }
                .padding()
            }
   
          
        }
        .alert(tituloResultado, isPresented: $mostrarResultado) {
            Button("Próximo", action: perguntar)
        }
    }
    func tocouNaBandeira(_ number: Int) {
        
        tentativas = tentativas + 1
        if number == respostaCorreta {
            resultado += 1
            tituloResultado = "Parabéns! você acertou"
        } else {
            tituloResultado = "Errou! Essa bandeira representa \(paises[number].uppercased())"
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
