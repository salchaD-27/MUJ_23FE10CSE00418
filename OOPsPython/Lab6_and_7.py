# 31. Class "Person" with name and age attributes. Create 2 instances of "Person", set their attributes using the constructor, and print their name and age. 
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
person1 = Person("Alice", 30)
person2 = Person("Bob", 25)
print(f"Name: {person1.name}, Age: {person1.age}")
print(f"Name: {person2.name}, Age: {person2.age}")

# 32. Class 'Student' with String variable 'name' and integer variable 'roll_no'. Assign roll no as '2' and name as "John" by creating an object of class. 
class Student:
    def __init__(self, name, roll_no):
        self.name = name
        self.roll_no = roll_no
student = Student("John", 2)
print(f"Name: {student.name}, Roll No: {student.roll_no}")

# 33. Class to represent a bank account, with methods to deposit, withdraw, and check the balance.
class BankAccount:
    def __init__(self, balance=0):
        self.balance = balance
    def deposit(self, amount):
        if amount > 0:
            self.balance += amount
            print(f"Deposited: {amount}. New Balance: {self.balance}")
        else:
            print("Deposit amount must be positive.")
    def withdraw(self, amount):
        if 0 < amount <= self.balance:
            self.balance -= amount
            print(f"Withdrew: {amount}. New Balance: {self.balance}")
        else:
            print("Insufficient balance or invalid amount.")
    def check_balance(self):
        print(f"Current Balance: {self.balance}")
account = BankAccount()
account.deposit(100)
account.withdraw(50)
account.check_balance()

# 34. Class Student with attributes like name and age, and create objects to represent different students.
class Student:
    def __init__(self, name, age):
        self.name = name
        self.age = age
student1 = Student("Alice", 20)
student2 = Student("Bob", 22)
print(f"Student 1: Name - {student1.name}, Age - {student1.age}")
print(f"Student 2: Name - {student2.name}, Age - {student2.age}")