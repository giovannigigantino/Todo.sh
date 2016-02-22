# Todo.sh
**Todo.sh** is a lightweight bash script that allows you to use general purpose *to do list* for your programs, shopping lists, notes or everything you need to keep in your mind. Your lists are stored in local *'/.todo'* text files so they are human-readable and editable with your favourite text-editor.

## Script configuration
Give it execution permissions:
```bash
# chmod +x /path/to/Todo.sh
```

Add in your *~/.bashrc* file:
```bash
alias todo='/path/to/Todo.sh'
```
## Use
* *todo init:* Iniatialize a list to in the current directory
* *todo add <"Thing">:* Add *"Thing"* to your list 
* *todo rm <ID>:* Remove from the list the selected element
* *todo ls:* Show a list with the elements of the list and their ID
* *todo check:* Check if in the current directory a todo list is initializated
* *todo destroy:* Remove the list from the current directory
* *todo help:* Show a short guide of Todo.sh

## Screenshot
![Script in action](https://github.com/giovannigigantino/Todo.sh/blob/master/img/example.png)

##### Contacts
*giovanni.gigantino.843@gmail.com*