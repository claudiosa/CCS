
	# include<stdio.h>
	  
      int factorial(unsigned int number)
	{
	    if(number <= 1)
	        return 1;
	    return (number * factorial(number - 1));
	}

	  
      int soma_recursiva(unsigned int number)
	{
	    if(number == 1)
	        return 1;
	    return (number + soma_recursiva(number - 1));
	}


      int fib(unsigned int number)
	{
	if(number == 0)
	        return 1;
	    	    
	if(number == 1)
	        return 1;
	    return (fib(number - 1) + fib(number - 2));
	}


	void main()
	{
	    int x = 10;
	    printf("Factorial of %d is %d\n ",x,factorial(x));
	    printf("\n Soma recursiva of %d is %d\n ",x,soma_recursiva(x));

	    printf("\n Fib %d is %d\n ", x , fib(x));
	
	}
