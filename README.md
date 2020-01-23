# Tree Secure

A not-so-serious cross-platform mobile app to spread the awareness of the heritage trees in Singapore.

Developed in 24 hours at NUS [Hack&Roll 2020](https://hacknroll.nushackers.org/).

**[Try it out](https://github.com/AaronCQL/tree-secure/releases): Android APK is available**

## Completed Features

1. An interactive map in the main "Discover Trees" page which shows the location markers of all the heritage trees in Singapore
    - The pictures, as well as various information regarding the heritage trees (common name, scientific name, description, height, girth, etc.) can be conveniently accessed by tapping on the location markers of a specific tree
    - Precise user GPS location combined with the location markers of the heritage trees can easily lead the user to a specific heritage tree
2. Trees can be "visited" when users are close enough (approximately 500m) to a tree
    - This is to gamify the otherwise "boring" concept of learning about trees and to encourage users to go and actually admire/explore the actual trees for themselves. Think Pokemon Go, but with trees instead
    - This list is user persisted and users can see which trees have already been visited by going to the "Visited Trees' page
3. Trees can be "adopted" by users by donating some money
    - This list is user persisted and users can see which trees have already adopted by going to the "Adopted Trees' page
    - *Proof of concept only*: the idea is for users to donate to the upkeep of the trees and/or to NParks. However, though Stripe is integrated and is working, only the testing key is used. We also did not seek nor have prior permission from NParks to solicit donations on their behalf
4. A beautiful UI experience which comes with both light *and* dark mode

## Stacks

1. **Flutter**: for the front end development of this cross-platform app
2. **Firebase**: including Firebase Authentication and Firestore to persist user settings and user data (eg. the lists of adopted and visited trees)
3. **BeautifulSoup**: for web scraping the [NParks website](https://www.nparks.gov.sg/gardens-parks-and-nature/heritage-trees) for the data of all the heritage trees. Interested developers can refer to [this directory](https://github.com/AaronCQL/trees-secure/tree/master/lib/data) for the source code
4. **Google Maps Platform**: for the Google Maps integration
5. **Stripe**: to facilitate donations

## Developers

- [Eugene Teu](https://github.com/EugeneTeu)
- [Wei Liang](https://github.com/uberSaiyan)
- [Li Zi Ying](https://github.com/ziyingli)
- [Aaron Choo](https://github.com/AaronCQL)

## Disclaimer

This app is made for educational purposes only. We are in no way affiliated to [NParks](https://www.nparks.gov.sg/) nor are we responsible for the accuracy of the dataset scraped from the NParks website (which we have last collected on 19 Jan 2020). Please do contact NParks directly if the data is found to be inaccurate.

Note also that the code in this repo may not be the most optimised nor the cleanest since certain sacrifices had to be made for the sake of saving time.
