 int conta_freq ( char x[] , char l )
   {
      int i = 0;
      int n = 0;
      for (i = 0; x[i] != '\0' ; i++)
      {
         if (x[i] == l)
            n++;
       }     
   
      return (n);
   }
