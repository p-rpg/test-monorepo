#ifndef LIBRARY_H
#define LIBRARY_H

#ifdef __cplusplus
extern "C" {
#endif

typedef struct Library *Library;

Library LibraryOpen(const char *path);
void *LibraryGet(Library self, const char *name);
void LibraryClose(Library self);

#ifdef __cplusplus
}
#endif

#endif
