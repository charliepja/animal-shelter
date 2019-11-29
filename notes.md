### SQL

Animals

name  | type  
--|--
animal_id| SERIAL PRIMARY KEY  
name  | VARCHAR  
breed  | VARCHAR  
trained  | BOOLEAN  
admission_date | DATE
owner_id  | INT FK DEFAULT 0  

---

Owners

name  | type  
--|--
owner_id  | SERIAL PRIMARY KEY  
name  | VARCHAR  
address  | VARCHAR
preference  | VARCHAR  

---

Animal can have one owner

Owner can have many animals

Default owner_id to 0 to represent owned by the shelter

---

### Ruby Classes

Animal:

 - animal_id
 - owner_id
 - name
 - breed
 - trained
 - admission_date


Owner:

 - owner_id
 - name
 - address
 - preference

---

### MVP

 - A list of all their animals and their admission date

	- `Animal.all()`


 - Mark an animal as being adoptable/not adoptable

   - `animal1.can_adopt()`


 - Assign an animal to a new owner

   - `animal1.adopt(owner)`
   - `owner1.adopt(animal)`


 - List all the owners and their adopted animals

   - `Owner.all()`
   - `Animal.get_owner(owner)`


---

`Animal.all()`

> SELECT * FROM animals
>
> Returns all the data from the animal table


`animal1.can_adopt()`

> UPDATE animals SET () = () WHERE animal_id = $1
>
> Changes the value of trained to True or False


`animal1.adopt(owner)`

> UPDATE animals SET () = () WHERE animal_id = $1
>
> Changes the owner_id to have the id of the new owner
>
> Takes in the owner object as a param


`owner1.adopt(animal)`

> Calls the Animal.adopt method

`Owner.all()`

> SELECT * FROM owners
>
> SELECT * FROM animals WHERE owner_id = $1
>
> Will need to loop through the owners and find all the animals with that owner_id
>
> Returns a map with Owner Name & Animal Name
