# AskAI

AskAI provides an approachable, native to iOS experience for interfacing with ChatGPT, and saving chats for later. It's written with almost entirely SwiftUI, and uses MVVM architecture. Chat engine images generated with Midjourney.

<b> Getting Started </b>
* To receive responses from ChatGPT, you'll need an API key from OpenAI. Keys are available for free at https://openai.com/api/
* Insert API key in AskAI/ViewModels/OpenAIViewModel.swift

<i>The below images and guidance are accurate as of a previous version of AskAI. Currently the app loads into HomeView, which is now the middle of three tabs: ChatGPT, Home, DALL·E. Previously, the app loaded into what is now ChatGPTMainView, and that tab provides an almost identical experience to what is showcased below. InfoView, and the button that brings it up in a sheet, have been moved to the HomeView experience. 

Current bug(s):
* SavedChats logic needs to be revisited. Images are showing up in ChatGPTMainView saved chats, and on app launch, data objects are not managed correctly.

</i>

<b> HomeView </b>
![AskAI Showcase 2 001](https://user-images.githubusercontent.com/110639779/216637844-f31c94e1-75f8-413a-a940-12ad3d9e3812.jpeg)
The app launches into HomeView and provides three major paths of navigation: ChatView, SavedChats, and InfoView. User may choose to begin a new chat with one of the four available chat engines: Davinci, Curie, Babbage, and Ada. If the user has saved chats, they will appear in a list of navigation links with a SavedChatView as its destination. Items in this list respond to swipe gestures from the leading and trailing edges, as well as a context menu that appears as a result of a press-and-hold gesture. User may tap the info button to reveal a sheet with chat engine overviews and credits.

<b> ChatView </b>
![AskAI Showcase 2 002](https://user-images.githubusercontent.com/110639779/216637870-d2206aa8-9c26-444b-9f7c-78e68edf47c1.jpeg)
Each ChatView instantiates its own ChatViewModel so that request and response data are preserved when user navigates away from the view. This environment is conditionally managed so that the user is sandboxed to the intended implementation. User may not submit an empty request, nor are the save/delete buttons tappable prior to receiving a response or error from ChatGPT. Submit button dismisses the iOS keyboard, animates while waiting for a response, and once again upon receipt. User may clear the chat, with an alert to make sure they meant to. User may save the chat, with an alert notifying success.

* <i>Submit button adapted from Polly Vern's Slider Button (https://github.com/PollyVern/SwiftUI-Animations)</i>
* <i>OpenAI API Client Library in Swift from Adam Rushy (https://github.com/adamrushy/OpenAISwift)</i>

<b> SavedChatView and InfoView </b>
![AskAI Showcase 2 003](https://user-images.githubusercontent.com/110639779/216637878-0a52554f-5010-4272-9d06-3542a7d2bc74.jpeg)
SavedChatView displays a chat with the interaction date in the navigation bar, engine image (with optional favorite badge), user request, and ChatGPT response. As an easter egg, the user may drag the image around the screen, and it will return to its original position upon release. InfoView provides users with more information about working with each chat engine, and credits/links to OpenAI and connecting with the developer.

Future Updates:
* Add ability to save images, both in app, as well as to Photos
* Add UserProfileView 
* Optional biometric authentication at sign-in
