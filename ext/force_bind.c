#include "ruby.h"

struct METHOD {
    VALUE oclass;
    VALUE rclass;
    VALUE recv;
    ID id, oid;
    struct RNode *body;
};

static VALUE
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

void
Init_force_bind()
{
    rb_define_method(rb_cUnboundMethod, "force_bind", umethod_force_bind, 1);
}