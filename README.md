## Food Shop

This just a project I made it to learn about Flutter, Lavarel, and GetX. This will be an application that can help a restaurant to do bussiness online.This project just a code step-by-step course I find and recode.

## Getting Started

Economic application simulation application for a restaurant. The purpose of this app is to improve my skill set in Flutter app development with Getx

Backlog:

| Name feature     | Priority |
| ---------------- | -------: |
| Main screen      |        1 |
| Auth             |        0 |
| Cart             |        2 |
| Purchase history |        3 |
| Order online     |        4 |
| Payment handler  |        5 |
| Comment          |        6 |
| Rating           |        7 |

## Route rule

The purpose of this application is to help users buy food and order it at home. Users can choose food and create a shopping cart before paying. Use GPS to inject current address and handle approve payment

### Spring 1-5-2022 (3 week):

Note: All features of collection backlog extraction must be fully developed and demoable

- Extract form backlog:
  (Already sorted by priority)

* Main Screen
* Purchase history
* Cart
* Auth

Pre prepair:

- For testting and test the final demo feature, create a tool to collect data and push to the database repository

#### Model rule

- User:

| field name   |   type   | rule                                                                                                  |
| ------------ | :------: | :---------------------------------------------------------------------------------------------------- |
| name         |  string  | not null                                                                                              |
| password     |  string  | more than 8 character. At least 1 uppercase character, number, special symbol and lowercase character |
| email        |  string  | email type, not null, unique                                                                          |
| birth        | datetime | not null, selected date no later than today                                                           |
| gender       |  string  | include [female, male, private], default is private                                                   |
| avatar       |  string  |                                                                                                       |
| updated date | datetime |                                                                                                       |

- Comment

| field name |   type   | rule                       |
| ---------- | :------: | :------------------------- |
| user       |   User   | not null                   |
| comments   |  string  | not null                   |
| datePost   | datetime | not null                   |
| stars      |  double  | between 0 and 5, default 0 |

- Food:

| field name  |   type    | rule                                               |
| ----------- | :-------: | :------------------------------------------------- |
| name        |  string   | not null                                           |
| images      | [string]  | not empty                                          |
| comments    | [comment] |                                                    |
| finalRate   |  double   | between 0 and 5, default 0                         |
| timePrepare |    int    | more than 5                                        |
| status      |  string   | include [normal, empty, little], default is normal |
| description |  string   | not null                                           |
| price       |  double   | not null                                           |

- Food in cart: match with food model data

| field name |   type   | rule                   |
| ---------- | :------: | :--------------------- |
| name       |  string  | not null               |
| image      |  string  | not null               |
| options    | [string] |                        |
| price      |  double  | not null               |
| quantity   |   int    | default 1, more than 1 |
| time       |   int    | more than 5, defaul 5  |

- Cart:

| field name  |      type      | rule                                                              |
| ----------- | :------------: | :---------------------------------------------------------------- |
| create Date |    datetime    | default now                                                       |
| foods       | [food in cart] | not empty                                                         |
| status      |     string     | includes [accept, prepare, shipping, done, reject], defaul accept |

#### Detail route

##### Auth: Use jwt to help store current login session

- Sign in: Sign in with email and password, user just use once email for each account and don't duplicate
- Sign up: Create accout with
- Sign out: Clear all store in local storage
- Forgot password: Change password with email

note: Two-step verification is not supported yet

##### Home: Includes two collections, one is common food and the other is popular food

- Common food collection: Food is popular and user reviews and ratings will be at the top (push to home screen). Among foods with the same number of user comments, the foods will be sorted by name. (Quantity: 10)
- Popular food collection: food with the most reviews will be pushed to the main screen. Among foods with the same number of user comments, the foods will be sorted by name. (Quantity: 6)
- Common food detail: show info of food
- Popular food detail: show info of food

##### Cart: Display the list of food items in the shopping cart

- Display detailed food. With each food in the list will be displayed with each type of screen such as:
  - Common food: Show common food detail screen
  - Popular food: Show popular food detail screen
  - V.v ...
- Still store the food cart when the app is off

##### History cart: Display the list of history shopping cart

- Display cart history list. Cart history will be generated when this cart is checked out.

## Technology

- Flutter 2.10.5 - Frontend
- GetX: - Frontend state managerment
- NodeJS: Backend
