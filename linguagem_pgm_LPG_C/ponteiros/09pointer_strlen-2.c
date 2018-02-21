size_t strlen (const char *str)
{
	size_t len = 0U;
	while (*(str++))
		++len;
	return len;
}
