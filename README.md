## banking_FT

### About this app

This is a simple app which performs new customer registration for new ban accounts and provides existing customers with log in option, as well as the options of making transactions and viewing previous transactions.


### features

**Creating new accounts**: new account can be generated for new customers. Each customer can have multiple accounts with different account numbers which is a 12 digit number generated by the app. By choosing the first option in the menu, the name of the customer is asked and a welcome message with new account number will be returned to the customer with an instruction that the user needs to record it as it is the only way he/she will be able to log in to his/her account later.

**Existing customers**: can log in using the name they have entered when creating account. Upon selecting the second option from the menu, existing user is asked to enter his/her account number given at the registration step. If either the name or account number is not correct or they do not match, this question will be asked for two more times. If for the third time, user's inputs do not match the records, the app stops the log in process and displays a message which asks the user to contact bank customer service to resolve his/her problem with logging in.

**Transaction**: Either the new customers or existing customers can use this app to make transactions as deposit and withdraw. Also there is the possibility of viewing previous transactions as this option is included in the app. By the way, while making transactions, they can ask for their current account balance to make sure how much they are allowed to withdraw from their accounts. If a customer, by mistake, enters a negative value, a message pops up which warns the user that is not a valid amount and redirects him/her to enter a valid positive amount. If the user enters something which is not a number, the app takes him back to the option menu to kick off transaction again and whether if he/she wants to make deposit or withdraw or exit the app. All transactions are saved upon exiting the transaction phase.   

### Link
https://github.com/mahdibahadori/banking_FT.git

### Installation
1. Install Ruby on your machine, preferably use [asdf](https://asdf-vm.com/#/)
2. Install [git](https://git-scm.com/downloads)
3. ```git clone``` the app to your home directory by typing the below command in your terminal:

    ```git clone https://github.com/mahdibahadori/banking_FT.git```

4. Run the app ```setup``` executable file:

    ```banking_FT/bin/setup```
5. Go to text editor and find ```.bash_profile``` in your home directory and add the below line:

    ``` export PATH="$PATH:$HOME/banking_FT/bin ```
6. Restart you terminal to make sure that ```.bash_profile``` loads the app into your PATH

7. Run the app from your home directory by typing ```banking```

### Project Management
I have used Trello to organise the banking app project steps and you can check that by viewing my [Trello board](https://trello.com/b/K7NlX18A/banking-terminal-app).

### Testing
I carried out multiple tests around six features of my app and all passed the tests. You can see the results of the test by opening this link: [banking_FT_Tests](https://docs.google.com/spreadsheets/d/18hhJgRc3eao79PjJ_con4FCQwsYqbySQlibmsvY9MHk/edit?usp=sharing).

### Error Handling
Error handling was satisfied through using **control flow and conditional statements**, and **tty-prompt** which eliminated the likelihood of throwing error and stopping the app from running in case of receiving incorrect user input. Appropriate messaged displayed to user once he enters a wrong input to that specified field. Several features were tested against incorrect entries and all returned what they expected to do.
