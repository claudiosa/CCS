/*
 Removal of tail recursion is so simple
 that some compilers do it automatically.
 Even so, it is best not to find out that
 yours does not.
*/
void    print_list( lista  *L )
{
/*1*/       if( L != NULL )
{
/*2*/            print_element( L->element );
/*3*/            print_list( L -> next );
}
}