# GameNet
App created in UIKit in order to control users' games library. 
It's developed in Swift 5 with Storyboard, and relies in a ASP.Net API backend.

Those are some features:

## Dashboard
Shows stats like Playing Games (Jogando), physical and digital owned games, finished by year (Finalizados por Ano), bought by year (Comprados por ano) and games per platform (Jogos por Plataforma).
Also shows the entire price payed for users' library.

<p align="center">
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/Dashboard.png" alt="Dashboard" width="200"/>
</p>

## Games
It keeps registers of games that user is currently playing, along with start and finish gameplay date. The main screen is a Collection View, that shows all the covers. The detail screen shows price, gameplay date and all the times that user played this specific game.

<p align="center">
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/Games.png" alt="Games" width="200"/>
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/GameDetail.png" alt="Games Detail" width="200"/>
</p>

## Platforms
All the platforms owned by user
<p align="center">
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/Platforms.png" alt="Platforms" width="200"/>
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/NewPlatform.png" alt="New Platform" width="200"/>
</p>

## Lists (WIP)
Helps the user to create some lists. Example: Best The Legend of Zelda games, Buy Next, Play Next, and everything the user wants to create
<p align="center">
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/Lists.png" alt="Lists" width="200"/>
<img src="https://github.com/allistoncarlos/GameNet.UIKit/blob/master/Screenshots/NewList.png" alt="New List" width="200"/>
</p>

### Pods
It uses some pods
* [Alamofire 5.4](https://github.com/Alamofire/Alamofire)
* [Keychain Access](https://github.com/kishikawakatsumi/KeychainAccess)
* [Swinject](https://github.com/Swinject/Swinject)
* [SDWebImage](https://github.com/SDWebImage/SDWebImage)
* [SwiftyFORM](https://github.com/neoneye/SwiftyFORM)

### Architecture and design patterns
MVVM (previously used MVP), Coordinator, DI (using Swinject)

### Known bugs
* Status bar glitches
* Not prepared for light mode
* Pagination in games' view crashes the app when the user tries to select another game

### Next steps
- [ ] Finish lists feature
- [ ] Correct the bugs
- [ ] Unit Tests
- [ ] Migrate to CleanArchitecture
- [ ] Get rid of Storyboard, migrating it to Viewcode
- [ ] Use iCloud