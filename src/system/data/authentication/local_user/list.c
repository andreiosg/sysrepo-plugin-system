#include "list.h"
#include "system/data/authentication/local_user.h"

#include <string.h>
#include <stdlib.h>
#include <utlist.h>

void system_local_user_list_init(system_local_user_element_t **head)
{
	*head = NULL;
}

int system_local_user_list_add(system_local_user_element_t **head, system_local_user_t user)
{
	system_local_user_element_t *new_el = (system_local_user_element_t *) malloc(sizeof(system_local_user_element_t));

	if (!new_el) {
		return -1;
	}

	// copy value
	system_local_user_init(&new_el->user);
	system_local_user_set_name(&new_el->user, user.name);
	system_local_user_set_password(&new_el->user, user.password);

	// add to list
	LL_APPEND(*head, new_el);

	return 0;
}

system_local_user_element_t *system_local_user_list_find(system_local_user_element_t *head, const char *name)
{
	system_local_user_element_t *found = NULL;
	system_local_user_element_t el = {
		.user = {
			.name = (char *) name,
		},
	};

	LL_SEARCH(head, found, &el, system_local_user_element_cmp_fn);

	return found;
}

int system_local_user_list_remove(system_local_user_element_t **head, const char *name)
{
	system_local_user_element_t *found = system_local_user_list_find(*head, name);

	if (!found) {
		return -1;
	}

	// remove and free found element
	LL_DELETE(*head, found);
	system_local_user_free(&found->user);
	free(found);

	return 0;
}

int system_local_user_element_cmp_fn(void *e1, void *e2)
{
	system_local_user_element_t *s1 = (system_local_user_element_t *) e1;
	system_local_user_element_t *s2 = (system_local_user_element_t *) e2;

	return strcmp(s1->user.name, s2->user.name);
}

void system_local_user_list_free(system_local_user_element_t **head)
{
	system_local_user_element_t *iter_el = NULL, *tmp_el = NULL;

	LL_FOREACH_SAFE(*head, iter_el, tmp_el)
	{
		LL_DELETE(*head, iter_el);
		system_local_user_free(&iter_el->user);
		free(iter_el);
	}

	system_local_user_list_init(head);
}
