.globl main
.globl done
.globl divison
.globl sft
.globl res
.globl loop

.data
str1: .asciiz "Enter dividend:"
str2: .asciiz "Enter divisor:"
str3: .asciiz "The quotient is:"
str4: .asciiz "\n"
str5: .asciiz "The remainder is:"

.text
divison:sub $v1, $v1, $a2   #subtract remainder - divisor
		addi $t3, $t3, 1    #increment the counter
  		slt $t1, $v1, $0    #remainder<0 
   		beq $t1, $0,  sft   #branch to sft
    	add $0, $0, $0		#nop
		j res   			#or jump to res
	 	add $0, $0, $0      #nop
loop:	srl $a2, $a2, 1     #shift divisor right 1 bit
	   	slt $t0, $t3, $t2   #set counter<17  
	    bne $t0, $0, divison #branch to dive if counter<17 
		add $0, $0, $0      #nop
		jr $ra				#go back to main after 16th time
		add $0, $0, $0		#nop
res:	add $v1, $v1, $a2	#restoring the remainder
		sll $a3, $a3, 1		#shift the quotient to the left 
		j loop				#jump to loop
		add $0, $0, $0		#nop
sft:	sll $a3, $a3, 1		#shift the quotient to the left	
		addi $a3, $a3 , 1	#rightmost bit 1
		j loop				#jump to loop
		add $0, $0, $0		#nop
main:	addi $v0, $0, 4
		lui $a0, 0x1000		#address of str1
		syscall				#display str1
		addi $v0, $0, 5		#get dividend
		syscall
		add $a1, $0, $v0	#store value of dividend in a1
		addi $v0, $0, 4
		addi $a0, $a0, 16	#address for str2
		syscall
		addi $v0, $0, 5		#get divisor
		syscall 
		add $a2, $0, $v0	#store value of divisor in a2
		sll $a2, $a2, 16	#shift left 16 times
		add $v1, $0, $a1	#set remainder=dividend
		add $a3, $0, $0		#initialize the quotient
		addi $t2, $0, 17	#initialize t2 as 17 to check counter
		add $t1, $0, $0		#initialize temporary register
		add $t3, $0, $0		#initialize counter register
		jal divison			#jump and link division
		add $0, $0, $0		#nop
		addi $v0, $0, 4
		lui $a0, 0x1000		
		addi $a0, $a0, 31	#address for str3
		syscall
		addi $v0, $0, 1
		add $a0, $0, $a3	
		syscall				#display quotient
		addi $v0, $0, 4
		lui $a0, 0x1000
		addi $a0, $a0, 48	#address for str4
		syscall
		addi $v0, $0, 4
		lui $a0, 0x1000
		addi $a0, $a0, 50	#address for str5	
		syscall				#display str5
		addi $v0, $0, 1
		add $a0, $0, $v1	#store remainder in a0
		syscall				#display remainder
		addi $v0, $0, 4
		lui $a0, 0x1000
		addi $a0, $a0, 48	#address for str4
		syscall
		j done				#jump to done
		add $0,$0, $0		#nop
done:	j main				#jump to main
		add $0, $0, $0		#End of program. Set breakpoint
