# 40. Program for division operation. Use a try-except block to catch and display an error message if the user enters zero, causing a ZeroDivisionError.
try:
    divisor = int(input("Enter a divisor: "))
    result = 100 / divisor
    print(f"Result: {result}")
except ZeroDivisionError:
    print("Error: Division by zero is not allowed.")

# 41. Program for division operation. Use a try-except-finally block ensuring that a message, "Execution completed," is printed regardless of whether an exception occurs.
    def divide_numbers():
        try:
            num1 = float(input("Enter the first number: "))
            num2 = float(input("Enter the second number: "))
            result = num1 / num2
            print(f"Result: {result}")
        except ZeroDivisionError:
            print("Error: Division by zero is not allowed.")
        except ValueError:
            print("Error: Invalid input. Please enter numeric values.")
        finally:
            print("Execution completed.")
divide_numbers()

# 42. Program to let user to enter a filename and open it. Use a try-except-else block to catch a FileNotFoundError if the file does not exist. 
try:
    filename = input("Enter the filename: ")
    file = open(filename, 'r')
except FileNotFoundError:
    print("Error: File not found.")
else:
    print("File contents:")
    print(file.read())
finally:
    try:
        file.close()
        print("File closed.")
    except NameError:
        print("No file to close.")

# 43. Define a custom exception class called NegativeNumberError. Program to let user enter positive number only and raises a NegativeNumberError otherwise.
class NegativeNumberError(Exception): pass
try:
    number = int(input("Enter a positive integer: "))
    if number < 0:
        raise NegativeNumberError("Error: Negative number entered.")
    else:
        print(f"Number entered: {number}")
except NegativeNumberError as e:
    print(e)

# 44. Program to use a try-except-else block to catch any ValueError if the input from user is not an integer.
try:
    number = int(input("Enter an integer: "))
except ValueError:
    print("Error: Invalid input. Please enter an integer.")
else:
    print(f"The square of the number is: {number ** 2}")
finally:
    print("End of program.")
