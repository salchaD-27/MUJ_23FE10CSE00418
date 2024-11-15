# 35. Create a complex number class with atributes real and imaginary and methods of add, magnitude, __str__
import math
class ComplexNumber:
    def __init__(self, real, imaginary):
        self.real = real
        self.imaginary = imaginary
    def add(self, other):
        return ComplexNumber(self.real + other.real, self.imaginary + other.imaginary)
    def magnitude(self):
        return math.sqrt(self.real**2 + self.imaginary**2)
    def __str__(self):
        return f"{self.real} + {self.imaginary}i"
c1 = ComplexNumber(3, 4)
c2 = ComplexNumber(1, 2)
print("Complex number c1:", c1)
print("Complex number c2:", c2)
c3 = c1.add(c2)
print("Addition of c1 and c2:", c3)
print("Magnitude of c1:", c1.magnitude())
print("\n-------\n")
# 36. Create a person and student class using inheritance
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def display(self):
        print(f"Name: {self.name}, Age: {self.age}")
class Student(Person):
    def __init__(self, name, age, student_id):
        super().__init__(name, age)
        self.student_id = student_id
    def display(self):
        super().display()
        print(f"Student ID: {self.student_id}")
s = Student("Alice", 20, "S12345")
s.display()
print("\n-------\n")
# 37. Implement multilevel inheritance with vehicle, car and electric car classes
class Vehicle:
    def __init__(self, brand):
        self.brand = brand
    def start(self):
        print(f"{self.brand} vehicle starting...")
class Car(Vehicle):
    def __init__(self, brand, model):
        super().__init__(brand)
        self.model = model
    def drive(self):
        print(f"{self.brand} {self.model} is driving...")
class ElectricCar(Car):
    def __init__(self, brand, model, battery_capacity):
        super().__init__(brand, model)
        self.battery_capacity = battery_capacity
    def charge(self):
        print(f"Charging {self.brand} {self.model} with battery capacity of {self.battery_capacity} kWh")
ecar = ElectricCar("Tesla", "Model S", 100)
ecar.start()
ecar.drive()
ecar.charge()
print("\n-------\n")
# 38. Implement multiple inheritance with teacher and author classes
class Teacher:
    def __init__(self, name, subject):
        self.name = name
        self.subject = subject
    def teach(self):
        print(f"{self.name} is teaching {self.subject}")
class Author:
    def __init__(self, name, books_written):
        self.name = name
        self.books_written = books_written
    def write(self):
        print(f"{self.name} has written {', '.join(self.books_written)}")
class TeacherAuthor(Teacher, Author):
    def __init__(self, name, subject, books_written):
        Teacher.__init__(self, name, subject)
        Author.__init__(self, name, books_written)
ta = TeacherAuthor("John Doe", "Mathematics", ["Algebra 101", "Calculus Made Easy"])
ta.teach()
ta.write()
print("\n-------\n")
# 39. Implement hybrid inheritance with animal, dog and cat classes
class Animal:
    def __init__(self, name):
        self.name = name
    def make_sound(self):
        print(f"{self.name} makes a sound.")
class Dog(Animal):
    def make_sound(self):
        print(f"{self.name} barks.")
class Cat(Animal):
    def make_sound(self):
        print(f"{self.name} meows.")
class Pet(Dog, Cat):
    def __init__(self, name, favorite_food):
        Animal.__init__(self, name)
        self.favorite_food = favorite_food
    def show_favorite_food(self):
        print(f"{self.name}'s favorite food is {self.favorite_food}")
pet = Pet("Buddy", "Bone")
pet.make_sound()  # Inherits Dog's make_sound method due to order of inheritance
pet.show_favorite_food()