# Mark Bellingham, 14032098, Options 1,2,3,4,5,6,7,8,9,10,11,12 implemented

.data
menu:	.ascii "\n"
	.ascii " 1, Enter Number 1 \n"
	.ascii " 2, Enter Number 2 \n"
	.ascii " 3, Display num1 and num2\n"
	.ascii " 4, Display sum of num1 and num2\n"
	.ascii " 5, Display product of num1 and num2\n"
	.ascii " 6, Divide num1 by num2\n"
	.ascii " 7, Exchange numbers 1 and 2\n"
	.ascii " 8, Display Numbers between num1 and num2\n"
	.ascii " 9, Sum numbers between num1 and num2\n"
	.ascii "10, Raise num1 to the power of num2\n"
	.ascii "11, Display prime numbers between num1 and num2\n"
	.ascii "12, Quit\n"
	.ascii "\n"
	.asciiz "Please enter menu option: "
	
str.num1.in: .asciiz "Please enter your first number: "
str.num2.in: .asciiz "Please enter your second number: "	
str.num1: .asciiz "Number 1 is "
str.num2: .asciiz "Number 2 is "
str.equals: .asciiz " = "
str.plus: .asciiz " plus "
str.mul: .asciiz " multiplied by "
str.div: .asciiz " divided by "
str.rem: .asciiz " remainder "
space: .asciiz " "
str.between: .asciiz "Numbers between "
str.and: .asciiz " and "
str.are: .asciiz " are: "
str.sum: .asciiz "Sum of numbers between "
str.power: .asciiz " to the power of "
str.prime: .asciiz "The prime numbers between "

.text
# Print menu using service number 4
printMenu:	#Label so we can jump back here
la $a0, menu
li $v0, 4
syscall

# Read user option using service number 5 (num goes into v0)
li $v0, 5
syscall

# Add user's choice into s3
add $s3, $zero, $v0

# Process menu
beq $s3, 1, opt1
beq $s3, 2, opt2
beq $s3, 3, opt3
beq $s3, 4, opt4
beq $s3, 5, opt5
beq $s3, 6, opt6
beq $s3, 7, opt7
beq $s3, 8, opt8
beq $s3, 9, opt9
beq $s3, 10, opt10
beq $s3, 11, opt11
beq $s3, 12, quit

# User selected an invalid option so print menu again
j printMenu



opt1:
# Enter number 1
# Print a request for number 1
la $a0, str.num1.in
li $v0, 4
syscall
# Receive input from the user, which goes into v0
li $v0, 5
syscall
# Put the number from v0 into s0 for longer storage
add $s0, $zero, $v0
j printMenu



opt2:
# Enter number 2
# Print a request for number 2
la $a0, str.num2.in
li $v0, 4
syscall
# Receive input from the user, which goes into v0
li $v0, 5
syscall
# Put the number from v0 into s1 for longer storage
add $s1, $zero, $v0
j printMenu



opt3:
# Display num1 and num2
# Print string for number 1
la $a0, str.num1
li $v0, 4
syscall
# Display the first number
add $a0, $zero, $s0,
li $v0, 1
syscall
# Move on to the next line
addi $a0, $zero, '\n'
li $v0, 11
syscall
# Print string for number 2
la $a0, str.num2
li $v0, 4
syscall
# Display the second number
add $a0, $zero, $s1
li $v0, 1
syscall
# Move on to the next line and reprint the menu. This
# code will be repeated so it is given the label 'lineSpace'
lineSpace:
addi $a0, $zero, '\n'
li $v0, 11
syscall
j printMenu



opt4:
# Display sum of num1 and num2
# Display the first number
add $a0, $zero, $s0
li $v0, 1
syscall
# Print 'plus' between the numbers
la $a0, str.plus
li $v0, 4
syscall
# Display the second number
add $a0, $zero, $s1
li $v0, 1
syscall
# Print the equals sign
la $a0, str.equals
li $v0, 4
syscall
# Add the two numbers together and print
addNumber:		# Will jump to here from opt9
add $a0, $s0, $s1
li $v0, 1
syscall
b lineSpace		# Prints the menu via opt3



opt5:
# Display product of num1 and num2
# Display the first number
add $a0, $zero, $s0
li $v0, 1
syscall
# Print the multiply string
la $a0, str.mul
li $v0, 4
syscall
# Display the second number
add $a0, $zero, $s1
li $v0, 1
syscall
# Print the equals sign
la $a0, str.equals
li $v0, 4
syscall
# Multiply the two numbers together and print
mul $a0, $s0, $s1
li $v0, 1
syscall
b lineSpace		# Prints the menu via opt3



opt6:
# Divide num1 by num2
# Display the first number
add $a0, $zero, $s0
li $v0, 1
syscall
# Print the divide string
la $a0, str.div
li $v0, 4
syscall
# Display the second number
add $a0, $zero, $s1
li $v0, 1
syscall
# Print the equals sign
la $a0, str.equals
li $v0, 4
syscall
# Do the division, extract the quotient from 'lo' and print
div $t0, $s0, $s1
mflo $a0
li $v0, 1
syscall
# Print the remainder string
la $a0, str.rem
li $v0, 4
syscall
# Extract the remainder from 'hi' and print
mfhi $a0
li $v0, 1
syscall
b lineSpace		# Prints the menu via opt3



opt7:
# Exchange numbers 1 and 2
# Swap the numbers using temporary storage at first
add $t0, $zero, $s0
add $s0, $zero, $s1
add $s1, $zero, $t0
# Print them out using the same instructions as in opt3
b opt3



opt8:
# Display Numbers between num1 and num2
# Put the first number into temporary storage
add $t0, $zero, $s0
# Display the initial text and put the output onto the next line
la $a0, str.between
li $v0, 4
syscall
add $a0, $zero, $s0
li $v0, 1
syscall
la $a0, str.and
li $v0, 4
syscall
add $a0, $zero, $s1
li $v0, 1
syscall
la $a0, str.are
li $v0, 4
syscall
addi $a0, $zero, '\n'
li $v0, 11
syscall

# These lines set initial values for the program to trigger a line break when 10 numbers are printed
li $s2, 0		# Initialise at 0
li $s3, 10		# Max line length is 10

# Enter the relevant loop depending on whether
# num1 is larger or smaller than num2
ble $s0, $s1, loop1
bgt $s0, $s1, loop2

# First loop is for when the first number is less than the second
loop1:
# Print the number in t0 (initially num1)
add $a0, $zero, $t0
li $v0, 1
syscall
# Puts a space between the numbers
la $a0, space
li $v0, 4
syscall
# Add 1 to the number in t0
addi $t0, $t0, 1

addi $s2, $s2, 1	# Counter which tells the program to 
beq $s2, $s3, newLine1	# move onto a new line when 10 numbers are printed
# If t0 is less than or equal to num2, repeat the loop
ble $t0, $s1, loop1

b lineSpace		# Prints the menu via opt3

# Moves the printed list onto the next line when called
newLine1:
addi $a0, $zero, '\n'
li $v0, 11
syscall
li $s2, 0		# Reset the newLine counter
ble $t0, $s1, loop1	# Repeat the loop to print the next 10 numbers

b lineSpace		# Prints the menu via opt3

# Second loop is for when the first number is greater 
# than the second and the list will count backwards
loop2:
# Print the number in t0 (initially num1)
add $a0, $zero, $t0
li $v0, 1
syscall
# Puts a space between the numbers
la $a0, space
li $v0, 4
syscall
# Subtract 1 from the number in t0
subi $t0, $t0, 1

addi $s2, $s2, 1	# Counter which tells the program to 
beq $s2, $s3, newLine2	# move onto a new line when 10 numbers are printed
# If t0 is greater than or equal to num2, repeat the loop
bge $t0, $s1, loop2

b lineSpace		# Prints the menu via opt3

# Moves the printed list onto the next line when called
newLine2:
addi $a0, $zero, '\n'
li $v0, 11
syscall
li $s2, 0		# reset the newLine counter
bge $t0, $s1, loop2	# Repeat the loop to print the next 10 numbers

b lineSpace		# Prints the menu via opt3


opt9:
# Sum numbers between num1 and num2
# Put the first number into temporary storage
# Also put the first number into t1 ready to do the sum
add $t0, $zero, $s0
add $t1, $zero, $t0
# Display the initial text
la $a0, str.sum
li $v0, 4
syscall
add $a0, $zero, $s0
li $v0, 1
syscall
la $a0, str.and
li $v0, 4
syscall
add $a0, $zero, $s1
li $v0, 1
syscall
la $a0, str.equals
li $v0, 4
syscall

# Enter the relevant loop
beq $s0, $s1, addNumber	# If the numbers are the same, add them using instructions in opt4
blt $s0, $s1, loop3	# If num1 is less than num2, jump to loop3
bgt $s0, $s1, loop4	# If num1 is greater than num2, jump to loop4 

loop3:
add $t0, $t0, 1		# Add one to t0
add $t1, $t1, $t0	# Add t0 to t1 and store the result in t1
bgt $s1, $t0, loop3	# If num2 is greater than t0, repeat the loop
printNumber:		# This will be re-used in opt9 and opt10
add $a0, $zero, $t1
li $v0, 1
syscall
b lineSpace		# Prints the menu via opt3

loop4:
sub $t0, $t0, 1		# Subtract 1 from t0
add $t1, $t1, $t0	# Add t0 to t1 and store the result in t1
blt $s1, $t0, loop4	# If num2 is less than t0, repeat the loop
b printNumber



opt10:
# Raise num1 to the power of num2
# Display the initial text
add $a0, $zero, $s0
li $v0, 1
syscall
la $a0, str.power
li $v0, 4
syscall
add $a0, $zero, $s1
li $v0, 1
syscall
la $a0, str.equals
li $v0, 4
syscall

beq $s1, $zero, loop6	# If the power is 0, jump to loop 6

# Put the first number into temporary storage
add $t1, $zero, $s0,
# Put the value 1 into t0 so that we can 
# compare it against the power for loop 7
addi $t0, $zero, 1

beq $s1, $t0, loop7	# If the power is 1, jump to loop 7

# Else Loop 5 is the default
loop5:
addi $t0, $t0, 1	# Increase the value of t0 by 1
mul $t1, $t1, $s0	# Multiply t1 by num2 and store the value in t1
blt $t0, $s1, loop5	# If t0 is less than num2, continue the loop
b printNumber

loop6:
addi $t1, $zero, 1	# Any number to the power of 0 is 1
b printNumber

loop7:
add $t1, $zero, $s0	# Any number to the power of 1 stays the same
b printNumber



opt11:
# Display prime numbers between num1 and num2
# Display the initial text and put the output onto the next line
la $a0, str.prime
li $v0, 4
syscall
add $a0, $zero, $s0
li $v0, 1
syscall
la $a0, str.and
li $v0, 4
syscall
add $a0, $zero, $s1
li $v0, 1
syscall
la $a0, str.are
li $v0, 4
syscall
addi $a0, $zero, '\n'
li $v0, 11
syscall

# Put the user input into temporary storage
move $t0, $s0
move $t1, $s1

li $t2, 1		# Will be used as a comparator in the divide loop

# These lines set initial values for the program to trigger a line break when 10 numbers are printed
li $s2, 0		# Initialise at 0
li $s3, 10		# Max line length is 10

blt $t0, $t1, primeLoop1
bgt $t0, $t1, primeLoop2

# This loop is for where the first number is smaller than the second
primeLoop1:
blt $t1, $s0, lineSpace	# If the program has counted down from num2 to num1, exit and print the menu via opt3
sub $t1, $t1, 1		# Subtracts one from the second number as a counter
li $t3, 2		# Divisors start at 2

ble $t0, 1, notPrime1	# 0, 1 and negative numbers are not prime

divide1:
div $t0, $t3
mflo $t4
blt $t4, $t3, foundPrime1# If the quotient is less than the divisor, stop
mfhi $t5
beq $t5, 0, notPrime1	# If the remainder is zero, the number is not prime
add $t3, $t3, 1		# Try the next divisor
j divide1

foundPrime1:
# Put the found prime number into a0 and print with a space following
move $a0, $t0
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
addi $s2, $s2, 1	# Counter which tells the program to 
beq $s2, $s3, newLine3	# move onto a new line when 10 numbers are printed

notPrime1:
add $t0, $t0, 1		# Moves to the next number
j primeLoop1		# Goes back to find another prime number

# Moves the printed list onto the next line when called
newLine3:
addi $a0, $zero, '\n'
li $v0, 11
syscall
add $t0, $t0, 1		# Moves to the next number
li $s2, 0		# Reset the newLine counter
j primeLoop1		# Goes back to find another prime number

# This loop is for where the first number is greater than the second
primeLoop2:
bgt $t1, $s0, lineSpace	# If the program has counted up from num2 to num1, exit
add $t1, $t1, 1		# Adds one to the second number as a counter
li $t3, 2		# Divisors start at 2

ble $t0, 1, notPrime2	# 0, 1 and negative numbers are not prime

divide2:
div $t0, $t3
mflo $t4
blt $t4, $t3, foundPrime2# If the quotient is less than the divisor, stop
mfhi $t5
beq $t5, 0, notPrime2	# If the remainder is zero, the number is not prime
add $t3, $t3, 1		# Try the next divisor
j divide2

foundPrime2:
# Put the found prime number into a0 and print with a space following
move $a0, $t0
li $v0, 1
syscall
la $a0, space
li $v0, 4
syscall
addi $s2, $s2, 1	# Counter which tells the program to 
beq $s2, $s3, newLine4	# move onto a new line when 10 numbers are printed

notPrime2:
sub $t0, $t0, 1		# Moves to the next number
j primeLoop2		# Goes back to find another prime number

# Moves the printed list onto the next line when called
newLine4:
addi $a0, $zero, '\n'
li $v0, 11
syscall
sub $t0, $t0, 1		# Moves to the next number
li $s2, 0		# reset the newLine counter
j primeLoop2		# Goes back to find another prime number



quit:
