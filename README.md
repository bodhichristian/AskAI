# AskAI

AskAI provides an approachable, native to iOS experience for interfacing with ChatGPT, and saving chats for later. It's written with almost entirely SwiftUI, and uses MVVM architecture.

Uses OpenAI API Client Library in Swift from https://github.com/adamrushy/OpenAISwift for submitting user request to ChatGPT and returning responses or errors accordingly.

<b> ContentView </b>
![AskAI Showcase 2 001](https://user-images.githubusercontent.com/110639779/216637844-f31c94e1-75f8-413a-a940-12ad3d9e3812.jpeg)
The app launches into ContentView and provides three major paths of navigation: ChatView, SavedChats, and InfoView. User may choose to begin a new chat with one of the four available chat engines: Davinci, Curie, Babbage, and Ada. If the user has saved chats, they will appear in a list of navigation links with a SavedChatView as its destination. Items in this list respond to swipe gestures from the leading and trailing edges, as well as a context menu that appears as a result of a press-and-hold gesture. User may tap in the info button to reveal a sheet with chat engine overviews and credits.

<b> ChatView </b>
![AskAI Showcase 2 002](https://user-images.githubusercontent.com/110639779/216637870-d2206aa8-9c26-444b-9f7c-78e68edf47c1.jpeg)
Each ChatView instantiates its own ChatViewModel so that request and response data are preserved when user navigates away from the view. This environment is conditionally managed so that the user is sandboxed to the intended implementation. User may not submit an empty request, nor are the save/delete buttons tappable prior to receiving a response or error from ChatGPT. Submit button dismisses the iOS keyboard and animates while waiting for a response, and once it is received. User may clear the chat, with an alert to make sure they meant to. User may save the chat, with an alert notifying success.

*Submit button adapted from Polly Vern's Slider Button (https://github.com/PollyVern/SwiftUI-Animations)

<b> SavedChatView and InfoView </b>
![AskAI Showcase 2 003](https://user-images.githubusercontent.com/110639779/216637878-0a52554f-5010-4272-9d06-3542a7d2bc74.jpeg)
SavedChatView displays a chat with the interaction date in the navigation bar, engine image (with optional favorite badge), user request, and ChatGPT response. As an easter egg, the user may drag the image around the screen, and it will return to its original position upon release. InfoView provides users with more information about working with each chat engine, and credits/links to OpenAI and connecting with the developer.
