size_t strlen(const char *str)
{
    size_t i;
    for (i = 0U; str[i]; ++i)
        ;
    /* When the loop exits, i is the length of the string */
    return i;
}
