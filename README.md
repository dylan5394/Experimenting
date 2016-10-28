# README #

### How to run the hw project ###

***CocoaPods was used to import frameworks so please load the .xcworkspace when testing, NOT the .xcodeproj***

This repo contains a project folder for a master project that contains each homework assignment in it. Run the app and then choose which homework you want to test from the table view. The app will then segue to the homework assignment you selected so that you may test it. 

There is also an image in the project directory that is proof that my app is working with crittercism and reporting crashes. The cocoapods assignment I did this for is located in the normal swift main project.


##Running the keychain homework ##
For the keychain homework, you must run the xcode project “Assignment6”. It is inside the Assignment6 folder. I created an entirely new xcode project for this assignment since I needed to make use of the app delegate functions.

Also, the functionality of the app is that it allows users to add credit card info and stores the credit card name along with the last 4 digits of the card. To add a card, click the “plus” button on the table view controller nav bar then enter the appropriate info and click “save”. The app assumes you will enter the correct info and does not error check. The app will then store the info to an array, convert the array to Json, then overwrite that json string in the keychain.

##Running the core data and map kit homework ##
This core data and mapkit homework was also done in a separate project, just like the keychain homework was. This project can be found in the folder “CoreDataAndMaps”. There is no outside information needed to use this app, simply open the CoreDataAndMaps project and run it in the simulator. A map will appear showing all of the data supplied in the json file, except the app has converted the json data to CoreData and accessed that data using CoreData.

##App Proposal##
The file containing my app proposal is called app_proposal.docx