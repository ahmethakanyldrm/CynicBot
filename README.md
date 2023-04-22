# CynicBot

## Table of Contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Api](#api)
* [Create Chat Completion](#create-chat-completion)

## General info
I developed this project with swiftUI framework. I used the OpenAI api. Cynic bot is a chatbot that responds by mocking the entered sentence. I used the chatgpt model as the model.



## Technologies
- Swift
- Xcode 
- swiftUI


## Api
- OpenAI Api <br>
https://platform.openai.com/

## Request Body
-  model
- messages
- role
- content
- temperature
- choices



## Create Chat Completion


```swift
 let openAISwift = OpenAISwift(authToken:"API KEY")
 let system: String = "Aşağıda sorulan soruya cevap ver ancak soru soran kişiyle dalga geçerek cevapla"
    
 let prompt : [ChatMessage] = [
                ChatMessage(role: .system, content: system),
                ChatMessage(role: .user, content: question)]
                    
                openAISwift.sendChat(with: prompt,model: .chat(.chatgpt),temperature: 2, choices: 1)
```


