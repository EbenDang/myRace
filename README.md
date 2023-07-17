# Genearl information

1. The project uses MVVM as a foundamental structure
2. It get dependency injection involved to make view model testable.
3. Get Alamofire and MBHUDProgress involved and integrate it as a swift package.
4. Using Combine and delegates
5. Get generic technic involed as well
6. Add a very simple unit test towards the sorting function in RaceViewModel


# Brife introduction

1. HttpServiceImpl implements the protocal HttpService, which provides the http communication with remote server
2. Using service locator design pattern to hold some global service and share them accross the entire app
3. Each custom uiviewcontroller and uiview inherited from base class, so it's easy for applying some global appearence.
4. Decouple the ui and biz logic.

# Screen recording

Please see the attached screen recording for your reference

# Implemented features

1. As a user, I should be able to see a time ordered list of races ordered by advertised start ascending
2. As a user, I should not see races that are one minute past the advertised start
3. As a user, I should be able to filter my list of races by the following categories: Horse, Harness & Greyhound racing
4. As a user, I can deselect all filters to show the next 5 from of all racing categories
5. As a user I should see the meeting name, race number and advertised start as a countdown for each race.
6. As a user, I should always see 5 races and data should automatically refresh
7. Building the app on UIKit and SwiftUI
