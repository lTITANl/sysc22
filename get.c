#include "kvs.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char* get(kvs_t* kvs, const char* key) {
    node_t* current = kvs->db;
    while (current != NULL) {
        if (strcmp(current->key, key) == 0) {
            // 해당 key를 찾았을 때, 값을 반환
            return strdup(current->value);
        }
        current = current->next;
    }
    // 해당 key를 찾지 못했을 때, -1을 반환
    return NULL;
}