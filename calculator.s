.globl main
.globl while1
.globl endwhile1
.globl while2
.globl endwhile2
.globl while3
.globl parse_string
.globl donee
.globl launch_addition
.globl addition
.globl doneee
.globl launch_subtract
.globl subtract
.globl launch_multiply
.globl multiply
.globl mulzero
.globl mulone
.globl mloop
.globl launch_divide
.globl divide
.globl res
.globl sft
.globl dloop
.globl stop
.globl while5
.globl error
.globl error1

.data
#w: .half 4
#v: .half 1
#x: .half 3
#y: .half 1
str1: .asciiz "2+3+4+2"
 
.text
main: 	addi $v0, $0, 4
		lui $a0, 0x1000							#address of str1
		syscall									#display string
		addi $t0, $a0, 0						#copy the address of a0 into t0			
		add $t1, $0, $0
while1:	
		
		lb $t2, 0($t0)							#load only the first byte i.e. 2
		#lh $t2, 0($t2)
		#slt $s1, $t2, 48						#check whether t2 is less than ascii value indicating its operator
		#bne $s1, $0, here						#if t2 is less than ascii branch to here
		#add $0, $0, $0							#nop
		addi $t2, $t2, -48						#ASCII value - 48= decimal value
		
error1:	beq $t2, $0, endwhile1					#if value reaches end point
	#	sll $t3, $t2, 3							#shift t2 to 3 i.e. 2^3=8
	#	sll $t4, $t2, 1							#shift t2 to 2 i.e. 2^1=2
	#	add $t2, $t4, $t3						#t2 should become 20 now
		addi $v0, $0, 1							#
		add  $a0, $0, $t2						#to print out the values of character in string
		syscall									#
		#sb $t2, 0($t0)							#store the decimal value at the same position where the first character was
		addi $sp, $sp, -4						#try to place stack over here
		sb $t2, 0($sp)							#	||
	#	addi $sp, $sp, -4						#	||
	#	add $t1, $0, $0							#counter to compare with stack pointer
		addi $t1, $t1, 4						#increase the counter by 4 each time sp is increased
		addi $t0, $t0, 1						#go to next byte
		j while1								#loop until the null character
		add $0, $0, $0							#nop

#here:	lb $t2, 0($t0)
#		beq $t2, $0, endwhile1
		
		

endwhile1:	
			addi $t0, $t0, -1					#decrease t0 as the address now point to null location
			
			j while5
			add $0, $0, $0
donee:		add $0, $0, $0			

parse_string:	
				addi $t3, $0, 43				#for addition
				addi $t4, $0, 45    			#for subtraction	 
				addi $t5, $0, 42				#for multiply
				addi $t6, $0, 47				#for division
				addi $t7, $0, 94				#for exponent
				addi $t8, $0, 37				#for percentage
				#jal while2
				#add $0, $0, $0					#nop
				j while3
				add $0, $0, $0

while4:			addi $sp, $sp, 4				#moving up the stack pointer to the largest address which symbolizes 1st character
				beq $sp, $t1, endwhile4			#	||
				add $0, $0, $0					#nop
				j while4						#	||
				add $0, $0, $0					#nop

endwhile4:		j while5
				add $0, $0, $0

while5:			slt $s0, $t1, $0
				bne $s0, $0, stop
				add $0, $0, $0
				lb $a1, ($sp)				#load the top element of the stack
				addi $t1, $t1, -4				#decrement t1=incrementing in stack
				addi $sp, $sp, 4
				lb $t9, ($sp)				#load operator into t9
				addi $t1, $t1, -4				
				addi $sp, $sp, 4
				lb $a2,  ($sp)				#load third element which should be variable for now into a2
				#addi $t1, $t1, -4	
				#slt $s0, $sp, $t1			
				#beq $0, $t1, stop 			
				#add $0, $0, $0
				addi $t1, $t1, -4
				add $0, $0, $0					
				j parse_string
				add $0, $0, $0

stop:			addi $v0, $0, 1					#
				add $a0, $0, $v1				#print the result(just for check)
				syscall							#
error:			add $0, $0, $0

while2:			lb $a1, 0($t0)					#load the byte into t2 from t0
				addi $sp, $sp, -4				#adjust stack for 1 item
				sb $a1, 0($sp)					#store 1 character in stack 
				add $s0, $0, $0
				addi $s0, $s0, 1	 
				addi $s1, $0, 3
				beq $s0, $s1, endwhile2	
				add $0, $0, $0					#nop
				addi $t0, $t0, 1				#increment
				j while2
				add $0, $0, $0					#nop
								
endwhile2:
				addi $t0, $t0, -1				#decrease t0 as the address now points to null location
				jr $ra							#go back to parse_string				
				add $0, $0, $0					#nop


while3:			#lb $a1, 8($sp)					#load first element from stack
				#lb $t9, 4($sp)					#load second element from stack
				#lb $a2, 0($sp)					#load third element from stack
				#addi $sp, $sp, 12				#increase the stack pointer after pop
				beq $t9, $t3, launch_addition	#for now check for addition
				beq $t9, $t3, launch_subtract	#check for subtraction
				beq $t9, $t5, launch_multiply	#check for multiply
				beq $t9, $t6, launch_divide		#check for divide
				add $0, $0, $0					#nop

#main:
#		lui $a0, 0x1000		#load address of str1 in a0
#		addi $v0, $0, 4		#print_string
#		syscall

#		addi $a0, $a0, 17	#load address of buffer
#		addi $a1, $0, 100	#set length to 100 for read string
#		addi $v0, $0, 8		#set syscall operation to 8 for read string
#		syscall

#		lui $a0, 0x1000
#		addi $a0, $a0, 17	#load address of string buffer

#		jal parse_string	#parse string
#		add $0, $0, $0		#nop

		
#parse_string:	#parse string returns v0 with opcode and two strings in arg0 and arg1
#				addi $t2, $0, 43	#t2=43=+
#				addi $t3, $0, 45	#t3=45=-
#				addi $t4, $0, 42	#t4=42=*
#				addi $t5, $0, 47	#t5=47=/
#				addi $t6, $0, 94	#t6=94=^
#				addi $t7, $0, 37	#t7=37=%
				
#				lui $t1, 0x1000		#load address of str1 initially in t1
#				addi $t1, $t1, 18	#load address for arg0

#parse_while:	lb $t0, 0($a0)		#load byte into t0
#				beq $t0, $t2, parse_add		#if current byte==43
#				beq $t0, $t3, parse_sub
#				beq $t0, $t4, parse_mult
#				beq $t0, $t5, parse_div
#				beq $t0, $t6, parse_exp
#				beq $t0, $t7, parse_per
#				sb $t0, 0($t1)		#store character into arg0
#				addi $a0, $a0, 1	#increment a0
#				addi $t1, $t1, 1	#increment t1

#				j parse_while		#loop again
#				add $0, $0, $0		#nop

#parse_add:		addi $v0, $0, 0		#load v0 with opcode 0
#				addi $a0, $a0, 1	#increment a0
				
#USE STACKS AND REMEMBER TO CHECK THE CASES WHEN LINK REGISTER VALUE IS OVERWRITTEN!!

#suppose that the two numbers on which operation are to be done are stored in a1 and a2
#check for whether number is negative or positive

#conditions that are needed to be checked or set up before and after addition
launch_addition:	#check if the value stored in a1 and a2
					#check whether a1 and a2 are negative or positive
					jal addition	#jump and link addition
					add $0, $0, $0	#nop
					addi $a1, $v1, 0	#load returned int into a1
					#addi $v0, $0, 1		
					add $a0, $0, $v1	#load returned int into a0
					#syscall
					sb	$a0, ($sp)	#load value back again in stack
					j while5
					add $0, $0, $0
					#restore the sign convention as before and take in account any change that occured
addition:	add $v1, $a1, $a2		#normal addition
			jr $ra					#jump back
			add $0, $0, $0			#nop

doneee: 		add $0, $0, $0			#nop
#condtions that are needed to be checked or set up before and after subtraction

launch_subtract:		#check if the value stored in a1 and a2
					#check whether a1 and a2 are negative or positive
					jal subtract	#jump and link subtract
					add $0, $0, $0	#nop
					addi $v0, $0, 1
					add $a0, $0, $v1	#load returned int into a0
					syscall
					#restore the sign convention as before and take in account any change that occured
subtract:	sub $v1, $a1, $a2		#normal subtraction
			jr $ra					#jump back
			add $0, $0, $0			#nop
#conditions that are needed to be checked or set up before and after multiply
launch_multiply: 	#check if the value stored in a1 and a2
					#check whether a1 and a2 are negative or positive
					sll $a2, $a2, 16	#shift multipier 16 times left
					srl $a1, $a1, 16	#shift multiplicand 16 times right
					addi $t2, $0, 17	#initialize t2 as 17 to check counter
					add $t0, $0, $0		#initialize a temporary register
					add $t3, $0, $0 	#initialize the counter
					jal multiply		#jump and link multiply
					add $0, $0, $0		#nop
					addi $v0, $0, 1
					add $a0, $0, $v1	#load returned int into a0
					syscall
					#retore the sign convention as before and take in account any change that occured
#multiplication  for unsigned numbers
multiply:	addi $t3, $t3, 1		#increment the counter
			beq $a2, $0, mulzero	#check if multiplier is 0
			add $0, $0, $0			#nop
			j mulone				#or jump when multiplier is 1
			add $0, $0, $0			#nop

mulzero: 	j mloop					#jump to loop
			add $0, $0, $0			#nop

mulone:		add $v1, $v1, $a1		#add multiplicand to product
			j mloop					#jump to loop
			add $0, $0, $0			#nop

mloop:		sll $a1, $a1, 1			#shift multiplicand left one bit
			srl $a2, $a2, 1			#shift multipler right one bit
			slt $t0, $t3, $t2		#set counter<17
			bne $t0, $0, multiply	#branch to multiply if counter<17
			add $0, $0, $0			#nop
			jr $ra					#go back to where it was called from
			add $0, $0, $0			#nop

#conditions that are needed to be checked or set up before and after divide
launch_divide:	#check if the value is stored in a1 and a2
				#check whether a1 and a2 are negative and positive
				sll $a2, $a2, 16	#shift divisor left 16 times
				add $v1, $0, $a1	#set remainder=dividend
				add $a3, $0, $0		#initialize the quotient
				addi $t2, $0, 17	#initialize t2 as 17 to check counter
				add $t1, $0, $0		#initialize temporary register
				add $t3, $0, $0		#initialize counter register
				jal divide			#jump and link divide
				add $0, $0, $0		#nop
				addi $v0, $0, 1	
				add $a0, $0, $a3	#load returned quotient in a0
				syscall
				#restore the sign convention as before and take in account the change in sign of quotient and remainder
				#only focus on quotient as that is the final result!!

#divison for unsigned numbers
divide:		sub $v1, $v1, $a2		#subtract remainder-divisor
			addi $t3, $t3, 1		#increment the counter
			slt $t1, $v1, $0		#remainder<0
			beq $t1, $0, sft		#branch to sft
			add $0, $0, $0			#nop
			j res					#or jump to res
			add $0, $0, $0			#nop
dloop:		srl $a2, $a2, 1			#shift divisor right 1 bit
			slt $t0, $t3, $t2		#set counter<17
			bne $t0, $t0, divide	#branch to dive if counter<17
			add $0, $0, $0			#nop
			jr $ra					#go back to main after 16 time
			add $0, $0, $0			#nop
res:		add $v1, $v1, $a2		#restoring the remainder
			sll $a3, $a3, 1			#shift the quotient to the left
			j dloop					#jump to loop
			add $0, $0, $0			#nop
sft:		sll $a3, $a3, 1			#shift the quotient to the left
			addi $a3, $a3, 1		#rightmost bit 1
			j dloop					#jump to loop
			add $0, $0, $0			#nop

#conditions that are needed to be checked before and after percentage
launch_percentage:	#check if the value is stored in a1 and a2
					#check whether a1 and a2 are negative and positive
					sll $a2, $a2, 16	#shift divisor left 16 times
					add $v1, $0, $a1	#set remainder=divisor
					add $a3, $0, $0		#initialize the quotient
					addi $t2, $0, 17	#initialize t2 as 17 to check counter
					add $t1, $0, $0		#intialize temporary register
					add $t3, $0, $0		#initialize counter register
					jal divide			#jump and link divide
					add $0, $0, $0		#nop
					addi $v0, $0, 1
					add $a0, $0, $v1	#load remainder into a0
					syscall
					#restore the sign convention as before and take in acocunt the change in sign of quotient and remainder
					#only focus on the remainder as that is the final result!!

#conditions that are needed to be checked before and after exponent
launch_exponent:	#check if the value is stored in a1 and a2
					#check whether a1 and a2 are positive and negative
					jal exponent	#jump and link exponent
					add $0, $0, $0	#nop
					addi $v0, $0, 1	
					add $a0, $0, $v1	#load return value in a0
					syscall
					
#power function for 2 numbers
exponent:	addi $a3, $0, 1		#store value 1 in a3
			add $v0, $0, $a1	#initialize v0 to a1
			beq $a2, $0, powerzero	#if number is raised to power 0 it branches
			add $0, $0, $0		#nop
eloop:		beq $a2, $a3, eend 	#if power that number is raised to is 1 that branch to eend
			add $t0, $a2, $0	#store value of power in t0
			add $v1, $v0, $0	#assign product as v0 which is the number whose power is to be raised
			add $a1, $v1, $0	#assign v1 to a1 which is used in multiply
			add $a2, $a1, $0	#assign the number in a2  
			jal multiply		#jump and link multiply
			add $0, $0, $0		#nop
			add $a2, $t0, $0	#restore power to its original
			addi $a2, $a2, -1	#subtract the power by one
			j eloop				#loop again until power is equal to 1
			add $0, $0, $0		#nop

eend: 		jr $ra				#jump back
			add $0, $0, $0		#nop

done:	add $0, $0, $0		#nop


