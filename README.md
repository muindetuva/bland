# Bland [Book Land]

## Overview
This is a simple Book Lending Library application. The application allows registered users to browse available books, borrow a book, return a book, and see a list of books they currently have borrowed.
A Book Lending App that allows users to view and borrow books

## Setting Up and Running

### Prerequisites
Ensure you have the following installed
- Ruby `3.4.X`
- Rails `8.X.X`

### Setup
1. Clone the repository
```
git clone git@github.com:muindetuva/bland.git
```

2. Access the project folder
```
cd bland
```

3. Install dependencies
```
bundle install
```
4. Setup database
```
bin/rails db:create db:migrate db:seed
```
5. Start the dev server
```
bin/rails server
```
6. Access the app. Open `http://localhost:3000`


## Running Tests
To ensure everything is working correctly run the test suit
```
bin/rails test
```


### Note on Database Constraints & Testing  

This is my first time working with Rails, so I'm still getting my head around the **Rails way** of doing things.  

If you check the migrations, you'll see that I’ve added **database-level constraints** (e.g., `null: false`, `unique: true`). I personally believe that database constraints are a good idea for **basic integrity rules** like presence and uniqueness. However, from the Rails documentation, it seems that the Rails convention is to enforce constraints **only at the model level** using validations.  

Since I’m following a **TDD approach**, I’ve chosen to **only test model-level validations** (`validates`). If I were to test both **model validations and database constraints**, I’d end up with a lot of redundant tests. Given that this is a relatively simple app, I decided to **keep database constraints for safety but only test at the model level** to maintain a cleaner test suite.  

## The Deployed Application

You can access the live application at: **[bland.muindetuva.com](https://bland.muindetuva.com)**.

The full user journey, including account creation, login, and book borrowing, works as expected.

For quick access, you can use the following test credentials:
- **Email:** tuva@mail.com
- **Password:** password


