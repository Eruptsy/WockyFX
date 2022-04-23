#include <stdio.h>
#include <string.h>
#include <stdlib.h>

typedef struct Skrillec {
    char    *filepath[1024];
    char    *data[1024];
    void*   (*set_file)(sk, sk);
    void*   (*process)(sk);
    void*   (*print_data)(sk);
    void*   (*get_data)(sk);
} sk;

int __set_file(sk *s, char *path) {
    if(strlen(path) > 255) return 0;
    sprintf(s->filepath, "%s", path);
    return 1;
}

void __process(sk *s) {
    FILE *fd;
    fd = fopen(s->filepath, "r");
    fread(s->data, 1024, 1, fd);
    fclose(fd);
}

char __data(sk *s) {
    return s->data;
}

sk Build() {
    sk s;
    s.set_file = __set_file;
    s.process = __process;
    s.get_data = __data;
    return s;
}

int main(int argc, char **argv[]) {
    sk s = Build();
    
    // Setting file name
    char filepath[15];
    sprintf(filepath, "%s", argv[1]);
    int test = s.set_file(&s, filepath);

    // Testing
    printf("Exit Code: %d, Filepath: %s\r\n", test, s.filepath);

    // Gettting file data to struct field
    s.process(&s);

    // Printing data from struct field
    char *fag = s.get_data(&s);
    printf("%s", fag);
    return 0;
}