#define _POSIX_C_SOURCE 200809L

#include "../include/myfilefunctions.h"

#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h>

int wordCount(FILE* file, int* lines, int* words, int* chars)
{
    int current;
    int in_word = 0;

    if (file == 0 || lines == 0 || words == 0 || chars == 0) {
        return -1;
    }

    *lines = 0;
    *words = 0;
    *chars = 0;

    while ((current = fgetc(file)) != EOF) {
        (*chars)++;

        if (current == '\n') {
            (*lines)++;
        }

        if (isspace((unsigned char) current)) {
            in_word = 0;
        } else if (!in_word) {
            (*words)++;
            in_word = 1;
        }
    }

    if (ferror(file)) {
        return -1;
    }

    return 0;
}

int mygrep(FILE* fp, const char* search_str, char*** matches)
{
    char* line = 0;
    size_t line_capacity = 0;
    size_t match_capacity = 0;
    size_t line_length;
    ssize_t read_length;
    int match_count = 0;

    if (fp == 0 || search_str == 0 || matches == 0) {
        return -1;
    }

    *matches = 0;

    while ((read_length = getline(&line, &line_capacity, fp)) != -1) {
        if (strstr(line, search_str) == 0) {
            continue;
        }

        if ((size_t) match_count == match_capacity) {
            size_t new_capacity = match_capacity == 0 ? 4 : match_capacity * 2;
            char** resized_matches = realloc(*matches, new_capacity * sizeof(*resized_matches));

            if (resized_matches == 0) {
                free(line);
                while (match_count > 0) {
                    free((*matches)[--match_count]);
                }
                free(*matches);
                *matches = 0;
                return -1;
            }

            *matches = resized_matches;
            match_capacity = new_capacity;
        }

        line_length = (size_t) read_length;
        (*matches)[match_count] = malloc(line_length + 1);
        if ((*matches)[match_count] == 0) {
            free(line);
            while (match_count > 0) {
                free((*matches)[--match_count]);
            }
            free(*matches);
            *matches = 0;
            return -1;
        }

        memcpy((*matches)[match_count], line, line_length + 1);
        match_count++;
    }

    free(line);

    if (ferror(fp)) {
        while (match_count > 0) {
            free((*matches)[--match_count]);
        }
        free(*matches);
        *matches = 0;
        return -1;
    }

    return match_count;
}