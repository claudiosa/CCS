 struct STRUCT_FILA
  {
    int  front ;  		/*  or first */
    int  rear ;	  		/*  or last */
    int  capacidade ; 		 	
	//char entradas[ MAX_FILA ];
	char * entrada ;	
};
// e ainda
typedef  struct STRUCT_FILA  fila ;

	//typedef int MY_boolean;
	bool  fila_cheia  ( fila * F);
	bool  fila_vazia  ( fila * F);
	int tamanho_fila ( fila * F );
	fila * cria_fila (  int C );
	void chegada ( char x, fila * F); // entra ... char
	char  partida ( fila * F ); // diferente .. sai char
    void destroi_fila( fila *F);
