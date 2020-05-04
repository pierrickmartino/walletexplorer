# walletexplorer

## Target
Create a simple tool to summarize and analysis of a financial situation thanks to a transaction importation from online banking
1. Overview : 
    * Global situation with total amount 31.12 last year (or oldest date) versus now.
    * Total income by category by year and by month
    * Total outcome by category by year and by month
    * Total banking fees
2. Accounts :
    * Variation by account with income and outcome
    * Total banking fees by account
3. Transactions :
    * List of the transactions for the current month/year
    * Filters
    * Extraction
    * Importation
    * Each transaction will be updatable regarding its classification
4. Analysis :
    * Evolution of annual taxes during time
    * Evolution of expenses dedicated to a specific usage (car for example)

## Changelog
* 0.23 - TransactionType is now editable with long press on a card icon
* 0.22 - BugFix for version 0.21
* 0.21 - Improvement in the project organization + integration of 2 dependencies (provider & get_it) + use of view class to access firestore data (transaction)
* 0.20 - Integration of the circular_profile_avatar for transaction display
* 0.19 - Transactions - POC for open a SimpleDialor on longPress
* 0.18 - Accounts - Use data from Firestore to feed the list
* 0.17 - Accounts - Page layout re-organization
* 0.16 - Integration of the fl_chart library for chart display
* 0.15 - Overview - Improvement in the display of the chart in the listView
* 0.14 - Overview - Add a listView horizontal for chart display
* 0.13 - Add a custom font to the application - Manrope (+ Theme)
* 0.12 - Transactions - Improvement in the card layout and render
* 0.11 - Transactions - Use data from Firestore to feed the list
* Xtra - Ability to import a flat file JSON from UBS eBanking -> WalletImport
* 0.10 - Addition of a search engine for transactions (+ Theme)
* 0.9 - Bug - User avatar changes when we navigate between menu items (+ Theme)
* 0.8 - Bug - Fix label "Crypto App" on tab title
* 0.7 - Login page to authenticate the user (Firebase)
* 0.6 - Use of navigation_rail for navigation and menu
* 0.5 - Delete Buy/Sell functionality (not needed)
* 0.4 - Header - Use a screen to format the header panel
* 0.3 - Add mini chart on position widget
* 0.2 - Template from FlutterCryptoUI
* 0.1 - Initialisation du projet Flutter

## Useful links
* https://medium.com/@impaachu/how-to-upload-data-to-firebase-firestore-cloud-database-63543d7b34c5
* https://csvjson.com/csv2json (Id_transaction doit être la première colonne + utilisé Hash)
* https://google.github.io/charts/flutter/gallery
* https://github.com/imaNNeoFighT/fl_chart
* https://pub.dev/packages/circular_profile_avatar
* https://pub.dev/packages/provider
* https://pub.dev/packages/get_it

