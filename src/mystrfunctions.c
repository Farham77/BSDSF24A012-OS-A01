#include "../include/mystrfunctions.h"

int mystrlen(const char* s)
{
    int length = 0;

    if (s == 0) {
        return -1;
    }

    while (s[length] != '\0') {
        length++;
    }

    return length;
}

int mystrcpy(char* dest, const char* src)
{
    int index = 0;

    if (dest == 0 || src == 0) {
        return -1;
    }

    while (src[index] != '\0') {
        dest[index] = src[index];
        index++;
    }
    dest[index] = '\0';

    return 0;
}

int mystrncpy(char* dest, const char* src, int n)
{
    int index = 0;

    if (dest == 0 || src == 0 || n < 0) {
        return -1;
    }

    while (index < n && src[index] != '\0') {
        dest[index] = src[index];
        index++;
    }

    if (index < n) {
        dest[index] = '\0';
    }

    return 0;
}

int mystrcat(char* dest, const char* src)
{
    int dest_index = 0;
    int src_index = 0;

    if (dest == 0 || src == 0) {
        return -1;
    }

    while (dest[dest_index] != '\0') {
        dest_index++;
    }

    while (src[src_index] != '\0') {
        dest[dest_index] = src[src_index];
        dest_index++;
        src_index++;
    }
    dest[dest_index] = '\0';

    return 0;
}