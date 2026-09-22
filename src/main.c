#include <stdio.h>
#include <stdlib.h>

#include "../include/mystrfunctions.h"
#include "../include/myfilefunctions.h"

int main(void)
{
    char copied[32];
    char combined[64] = "Operating ";
    char limited[32];
    FILE* file;
    char** matches;
    int lines;
    int words;
    int chars;
    int match_count;
    int index;

    printf("--- Testing String Functions ---\n");
    printf("mystrlen(\"Systems\") = %d\n", mystrlen("Systems"));

    mystrcpy(copied, "Systems");
    printf("mystrcpy = %s\n", copied);

    mystrncpy(limited, "Operating Systems", 9);
    limited[9] = '\0';
    printf("mystrncpy = %s\n", limited);

    mystrcat(combined, "Systems");
    printf("mystrcat = %s\n", combined);

    printf("\n--- Testing File Functions ---\n");
    file = tmpfile();
    if (file == 0) {
        perror("tmpfile");
        return EXIT_FAILURE;
    }

    fputs("Operating systems\n", file);
    fputs("Multifile build\n", file);
    fputs("Operating systems assignment\n", file);
    rewind(file);

    if (wordCount(file, &lines, &words, &chars) != 0) {
        fprintf(stderr, "wordCount failed\n");
        fclose(file);
        return EXIT_FAILURE;
    }
    printf("wordCount: lines=%d, words=%d, chars=%d\n", lines, words, chars);

    rewind(file);
    match_count = mygrep(file, "Operating", &matches);
    if (match_count < 0) {
        fprintf(stderr, "mygrep failed\n");
        fclose(file);
        return EXIT_FAILURE;
    }

    printf("mygrep matches: %d\n", match_count);
    for (index = 0; index < match_count; index++) {
        printf("%s", matches[index]);
        free(matches[index]);
    }
    free(matches);
    fclose(file);

    return EXIT_SUCCESS;
}