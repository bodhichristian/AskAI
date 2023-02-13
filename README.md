# AskAI

AskAI provides an approachable, native to iOS experience for interfacing with ChatGPT, and saving chats for later. It's written with almost entirely SwiftUI, and uses MVVM architecture. Chat engine images generated with Midjourney.

<b> Getting Started </b>
* To receive responses from ChatGPT, you'll need an API key from OpenAI. Keys are available for free at https://openai.com/api/
* Insert API key in AskAI/ViewModels/OpenAIViewModel.swift


<b> HomeView </b>
![AskAI 2 0 Showcase 001](https://user-images.githubusercontent.com/110639779/218524293-b904249e-0d3b-4be3-9b69-617ba6e23274.jpeg)

The app launches into HomeView, the center of three tab experiences. On this view, users are greeted, presented with links for inspiration, and view stats related to their experience with AskAI. Tapping the gear icon reveals a sheet presenting SettingsView. Users can change their display name and color, and access information related to OpenAI and developer credits.

<b> DALLEView </b>
![AskAI 2 0 Showcase 002](https://user-images.githubusercontent.com/110639779/218525204-f94117e6-09c1-47d6-912a-0b4d58916edf.jpeg)
From the DALL·E tab, users can begin a new image generation prompt, or view previously saved images. Tapping on the info icon in the toobar presents a sheet displaying more detailed inforamtion DALL·E. Tapping on the Ask DALL·E Navigation Link pushes to DALLEPromptView. This environment, like ChatGPTPromptView, is conditionally managed so that the user is sandboxed to the intended implementation. User may not submit an empty request, nor are the save/delete buttons tappable prior to receiving a response or error from ChatGPT. Submit button dismisses the iOS keyboard, animates while waiting for a response, and once again upon receipt. User may clear the chat, with an alert to make sure they meant to. User may save the chat, with an alert notifying success. Tapping on saved images pushes to an instatiation of SavedChatView, presenting the user with the request and response in a messaging-style UI. As an easter egg, the user may drag the image around the screen, and it will return to its original position upon release.

* <i>Submit button adapted from Polly Vern's Slider Button (https://github.com/PollyVern/SwiftUI-Animations)</i>
* <i>OpenAI API Client Library in Swift from Adam Rushy (https://github.com/adamrushy/OpenAISwift)</i>

<b> ChatGPTView </b>
![AskAI 2 0 Showcase 003](https://user-images.githubusercontent.com/110639779/218526570-8d8ab9b5-6e42-4990-8828-3c35b04f6918.jpeg)
Users may begin a new chat with one of the four available chat engines: Davinci, Curie, Babbage, and Ada. If the user has saved chats, they will appear in a list of navigation links with a SavedChatView as its destination. Items in this list respond to swipe gestures from the leading and trailing edges, as well as a context menu that appears as a result of a press-and-hold gesture. User may tap the info button to reveal a sheet with chat engine overviews and credits.Each ChatView instantiates its own ChatViewModel so that request and response data are preserved when user navigates away from the view. Tapping on the info icon in the toobar presents a sheet displaying more detailed inforamtion about each engine.

Future Updates:
* Migrate to Core Data for data persistence 
* Allow users to save to Photos
* Allow users to upload or choose an avatar
* Optional biometric authentication at sign-in
