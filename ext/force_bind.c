#include "ruby.h"

#ifndef RUBY191

#include "method.h"

struct METHOD {
    VALUE recv;
    VALUE rclass;
    ID id;
	rb_method_entry_t me;
};

static void
bm_mark(void *ptr)
{
    struct METHOD *data = ptr;
    rb_gc_mark(data->rclass);
    rb_gc_mark(data->recv);
    rb_mark_method_entry(&data->me);
}

static void
bm_free(void *ptr)
{
    struct METHOD *data = ptr;
    rb_method_definition_t *def = data->me.def;
    if (def->alias_count == 0)
	xfree(def);
    else if (def->alias_count > 0)
	def->alias_count--;
    xfree(ptr);
}

static size_t
bm_memsize(const void *ptr)
{
    return ptr ? sizeof(struct METHOD) : 0;
}

static const rb_data_type_t method_data_type = {
    "method",
    bm_mark,
    bm_free,
    bm_memsize,
};

VALUE
umethod_force_bind(VALUE method, VALUE recv)
{
	struct METHOD *data, *bound;

	TypedData_Get_Struct(method, struct METHOD, &method_data_type, data);
	method = TypedData_Make_Struct(rb_cMethod, struct METHOD, &method_data_type, bound);
	*bound = *data;
	if (bound->me.def) bound->me.def->alias_count++;
	bound->recv = recv;
	bound->rclass = CLASS_OF(recv);

	return method;
}

#else

struct METHOD {
    VALUE oclass;
    VALUE rclass;
    VALUE recv;
    ID id, oid;
    struct RNode *body;
};

VALUE
umethod_force_bind(VALUE method, VALUE recv)
{
    struct METHOD *data, *bound;

    Data_Get_Struct(method, struct METHOD, data);
    method = Data_Make_Struct(rb_cMethod, struct METHOD, free, -1, bound);
    *bound = *data;
    bound->recv = recv;
    bound->rclass = TYPE(recv) == T_CLASS ? RCLASS(recv) : CLASS_OF(recv);

    return method;
}

#endif /* !RUBY191 */

void
Init_force_bind()
{
    rb_define_method(rb_cUnboundMethod, "force_bind", umethod_force_bind, 1);
}