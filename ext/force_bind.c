#include "ruby.h"

#ifdef RUBY192_OR_GREATER

#include "method.h"

struct METHOD {
	VALUE recv;
	VALUE rclass;
	ID id;
	rb_method_entry_t me;
};

/*
 * Similar to +UnboundMethod#bind+, but forces the bind regardless of the type.
 * @return [Method]
 */
VALUE
umethod_force_bind(VALUE method, VALUE recv)
{
	struct METHOD *data, *bound;
	const rb_data_type_t *type;

	type = RTYPEDDATA_TYPE(method);
	TypedData_Get_Struct(method, struct METHOD, type, data);
	method = TypedData_Make_Struct(rb_cMethod, struct METHOD, type, bound);
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

#endif /* RUBY192_OR_GREATER */

void
Init_force_bind()
{
	rb_define_method(rb_cUnboundMethod, "force_bind", umethod_force_bind, 1);
#if 0
	rb_cUnboundMethod = rb_define_class("UnboundMethod", rb_cObject); /* for docs */
#endif
}
