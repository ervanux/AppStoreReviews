<h1 align="center">AppStore Reviews App</h1>
---
This is a simple app which has only two screen and dummy UI. It is built for an Assessment. No third-party library used during the development. 

### Which features does AppStore Reviews App have?
---
- Lists customer reviews from App stores for a specific app.
- Filters reviews according to the selection.
- Shows top three words in the filtered results.

### What is the main overview of the App?
---
There are three targets in it.
- App 
    - Contains `Feedlist`, `Feeddetail`, `Model` and `Providers` folders
        - `Feedlist`: Used MVVM so it contains VC(View!), VM and table cells.
        - `Feeddetail`: Detail VC. I didn't touch it much. It is mature enough :)
        - `Model` contains all models and related protocols.
        - `Provides` contains model providers.
- Core
    - Contains common Network Parts and some useful extensions that used in the app. All of them are independent of the App Logic so it can be used anywhere. 
- Unit test
    - Contains a few tests for the app logic and performance measurement for functions.

PS: It is built on a provided draft version for Coding-Task. There is not so much difference on UI. UI is touched  only when needed. Business Logic and Architecture are main point as requested.

### How easy to extend this app in the future?
---
The Software Entities are built with `SOLID Design Principles` as much as possible. It helps developer build Scalable and Higly Configurable Software Entities.
`Composition over Inheritance` is one of the most key principle which is followed during the development of this application. It helps developer build their system based on functinal hierarcy not type. So extending/refactoring currect functionalities should not cost too much. 
Anyway, if we look at them in detail:

- There is a simple, generic and type safe `URLSession` extension to fetch json content from any url. To be able to call you have to give a url and the root model which should be codable of course. It returns standard `Result` with model and `FetchError`. 
- There is a collection extension which returns most occured words in the collection. The constraint is `Element` should be `CustomStringConvertible`. In the app side, `Review` model conforms it and used to most occurred words.
- `ReviewProvider` is the data repo which passed as a parameter to VC. VC passes its to VM and it starts getting models from provider. 
    - `AppStoreReviews` is an `ReviewProvider` which fetches reviews from internet as `AppStoreFeed` and converts to `Review` by `ReviewConvertible` protocol. Another `ReviewProvider` is `MockReviews`. It used for unittest. `MockReviews` provides review models with generating locally instead of fetching internet.
    - if someone wants to list GooglePlay reviews as well in the future, he should create a provider and pass corresponding json url and root model of the json(should conform `ReviewConvertible`) to `startFetching` function. He can use same `FeedViewController` and `FeedViewModel`. Note: I assumed that google play reviews should be listed different VC. If both store reviews should list same VC, then same provider can collect and merge and `OperationQueue`, `GCD`, `Combine` or any other third party like `RxSwift`... 

### What about performance?
---
- I tried to use value types as much as possible.
- Used extensions, instead of creating new types. 
- View controller classes are made `final` to speed up method dispatching and take advantage of other performance tweaks    

### What would you do if have more time?
---
- Migrating to `SwiftUI` could be the first item, if there is no requirement for iOS 12.
- Or making MVVM better, like using `KVO` instead of `Closures`. 
- `Combine` can be used to migrate reactive programing. 
