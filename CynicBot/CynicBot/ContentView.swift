//
//  ContentView.swift
//  CynicBot
//
//  Created by AHMET HAKAN YILDIRIM on 22.04.2023.
//

import SwiftUI
import OpenAISwift

struct ContentView: View {
    
    @State var question: String = ""
    @State var results : [String] = []
    
    
    let openAISwift = OpenAISwift(authToken:"Open AI key")
    let system: String = "Aşağıda sorulan soruya cevap ver ancak soru soran kişiyle dalga geçerek cevapla"
    
    var body: some View {
        VStack {
            Text("Cynic Bot").font(.title.bold())
            
            ScrollViewReader { proxy in
                
                ScrollView(.vertical, showsIndicators: false) {
                    ForEach(results, id: \.self) {result in
                        HStack {
                            Text("🤖").font(.system(size: 48))
                            TextField("",text: .constant(result),axis: .vertical)
                                .textFieldStyle(.roundedBorder)
                                .disabled(true)
                        }
                        .id(result)
                    }
                    
                    if results.isEmpty {
                        Text("Herhangi bir girdi yok....").foregroundColor(.gray)
                    }
                }
                
                .onChange(of: results) {value in
                    proxy.scrollTo(results.last)
                }
            }
            
            
            HStack(alignment: .bottom) {
                TextField("Soru Giriniz...",text: $question,axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                    .lineLimit(5)
                Button {
                    
                    let prompt : [ChatMessage] = [
                        ChatMessage(role: .system, content: system),
                        ChatMessage(role: .user, content: question)
                    ]
                    
                    openAISwift.sendChat(with: prompt,model: .chat(.chatgpt),temperature: 2, choices: 1) { result in
                        switch result {
                        case .failure(let error):
                            print(error.localizedDescription)
                        case.success(let success):
                            results.append(success.choices?[0].message.content ?? "Hmm🤔 Bende bilemedim.")
                        }
                    }
                    
                } label: {
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                        .resizable()
                        .frame(width: 32,height: 32)
                        .tint(.red)
                }

            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
