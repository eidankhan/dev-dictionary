
# Learn Python OOP Indently Notes

## Classes
 
A class is a blueprint for creating objects. It defines the properties (attributes) and actions (methods) that its objects will have.

Think of a **microwave** — the class is the design/blueprint, not the actual microwave you use.

```python
class Microwave:
    def __init__(self, brand):
        self.brand = brand

    def heat(self):
        print("Heating food...")
```

**Key takeaway:**
- Classes are templates for objects.
- They group related data and functions together.
- The `class` keyword is used to define them.

## Objects (Instances)
 
An object is a specific, usable version of a class — created from the class blueprint.
  
If the class is the **microwave blueprint**, an object is the **actual microwave in your kitchen**.

```python
bosch:Microwave = Microwave("Bosch")
print(bosch.brand)  # Bosch
bosch.heat()
```

**Key takeaway:**
- Objects are created by calling the class like a function.
- Each object can have different attribute values.
- Multiple objects can be made from the same class.


## `__init__` Method
 
A special method that runs automatically when a new object is created. It’s used to set up the object’s initial state.

  
When you **buy a microwave**, it comes with a brand label already set — `__init__` sets that label.


```python
class Microwave:
    def __init__(self, brand):
        self.brand = brand
```

**Key takeaway:**
- Always starts with double underscores before and after (`__init__`).
- Used to initialize attributes.
- `self` must be the first parameter.


## `self` Parameter
 
A reference to the current object being created or used. It lets you access attributes and methods inside the class.

  
`self` is like saying **"this microwave"** when talking about its brand or functions.


```python
class Microwave:
    def __init__(self, brand):
        self.brand = brand

    def heat(self):
        print(f"{self.brand} is heating food...")
```

**Key takeaway:**
- `self` is passed automatically when calling methods on an object.
- It’s not a keyword — you could name it something else, but `self` is the convention.
- Without `self`, methods can’t access the object’s data.


## Methods
 
Functions defined inside a class that describe the behaviors of its objects.

  
A microwave’s **heat** button is like a method — it performs an action.


```python
class Microwave:
    def heat(self):
        print("Heating food...")
```

**Key takeaway:**
- Methods always take `self` as the first parameter.
- They can use and modify the object’s attributes.
- Called using `object.method()` syntax.

## Adding Attributes After Creation
 
You can add new attributes to an object even after it’s been created.

  
Like **adding a sticker** to your microwave after buying it.


```python
my_microwave.color = "Silver"
print(my_microwave.color)  # Silver
```

**Key takeaway:**
- Python allows dynamic addition of attributes.
- Only affects that specific object, not the class or other objects.

## Multiple Objects
 
You can create many objects from the same class, each with its own data.
  
Different microwaves in different kitchens — same blueprint, different brands or colors.


```python
microwave1 = Microwave("Bosch")
microwave2 = Microwave("Samsung")
```

**Key takeaway:**
- Each object is independent.
- Changes to one object don’t affect others.

## Visual Diagram — Python OOP with Car Analogy
```
          ┌───────────────────────────┐
          │         Car Class          │
          │  (Blueprint / Template)    │
          │--------------------------- │
          │ Attributes: brand, color   │
          │ Methods: drive(), repaint()│
          └─────────────┬──────────────┘
                        │
        ┌───────────────┴────────────────┐
        │                                │
┌───────────────────┐          ┌───────────────────┐
│  Object: Toyota    │          │  Object: BMW      │
│  brand = "Toyota"  │          │  brand = "BMW"    │
│  color = "Red"     │          │  color = "Black"  │
│  self → Toyota data│          │  self → BMW data  │
│  drive() → "Toyota │          │  drive() → "BMW   │
│  is driving..."    │          │  is driving..."   │
└───────────────────┘          └───────────────────┘
```

**Legend:**
- **Class** = The blueprint (design of a car).
- **Object** = A real car built from that blueprint.
- **self** = The link inside methods that points to *this specific object’s* data.

## Full Example Code
```python
# Defining a class (blueprint)
class Car:
    # __init__ method to initialize attributes
    def __init__(self, brand, color):
        self.brand = brand      # attribute
        self.color = color      # attribute

    # Method (behavior)
    def drive(self, speed):
        print(f"{self.brand} is driving at {speed} km/h.")

    # Another method
    def repaint(self, new_color):
        self.color = new_color
        print(f"{self.brand} has been repainted to {self.color}.")

# Creating objects (instances) from the class
car1 = Car("Toyota", "Red")
car2 = Car("BMW", "Black")

# Using methods
car1.drive(60)
car2.drive(120)

# Accessing attributes
print(car1.brand)  # Toyota
print(car2.color)  # Black

# Changing an attribute using a method
car1.repaint("Blue")

# Adding a new attribute after creation (dynamic attribute)
car1.year = 2022
print(f"{car1.brand} was made in {car1.year}.")

# Showing that attributes are independent per object
print(f"{car2.brand} color: {car2.color}")
# car2 doesn't have 'year' unless we add it
```
