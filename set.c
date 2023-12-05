#include "kvs.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int set(kvs_t* kvs, const char* key, const char* value) {

    node_t* new_node = (node_t*)malloc(sizeof(node_t)); // 새로운 노드를 메모리에 할당
    if (!new_node) {
        printf("Memory allocation failed.\n");
        return -1;
    }
    strcpy(new_node->key, key); // 키를 새로운 노드에 복사

    new_node->value = strdup(value);  // 값에 대한 메모리를 할당하고 값을 새로운 노드에 복사
   
    new_node->next = kvs->db; // 새로운 노드를 연결 리스트의 맨 앞에 추가
    kvs->db = new_node;

    kvs->items++; // 아이템 개수 증가

    return 0;
}