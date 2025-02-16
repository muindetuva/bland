# Bland [Book Land]
A Book Lending App that allows users to view and borrow books


## 📌 Note on Database Constraints & Testing  

This is my first time working with Rails, so I'm still getting my head around the **Rails way** of doing things.  

If you check the migrations, you'll see that I’ve added **database-level constraints** (e.g., `null: false`, `unique: true`). I personally believe that database constraints are a good idea for **basic integrity rules** like presence and uniqueness. However, from the Rails documentation, it seems that the Rails convention is to enforce constraints **only at the model level** using validations.  

Since I’m following a **TDD approach**, I’ve chosen to **only test model-level validations** (`validates`). If I were to test both **model validations and database constraints**, I’d end up with a lot of redundant tests. Given that this is a relatively simple app, I decided to **keep database constraints for safety but only test at the model level** to maintain a cleaner test suite.  

This approach balances **Rails conventions, data integrity, and test efficiency.** 🚀  
