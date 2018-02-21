int main ()
{
    int a;
    int b;
    int const * ptr_a;
    int * const ptr_b;
    ptr_a = & a;
    * ptr_a = 42;
    ptr_b = & b;
    * ptr_b = 42;
    return 0;
}
