#include "ruby.h"

struct METHOD {
    VALUE oclass;
    VALUE rclass;
    VALUE recv;
    ID id, oid;
    struct RNode *body;
};

static VALUE
umethod_bind_class(VALUE method, VALUE recv)
{
    struct METHOD *data, *bound;

    Data_Get_Struct(method, struct METHOD, data);
    method = Data_Make_Struct(rb_cMethod, struct METHOD, free, -1, bound);
    *bound = *data;
    bound->recv = recv;
    bound->rclass = RCLASS(recv);

    return method;
}

void
Init_bind_class()
{
    rb_define_method(rb_cUnboundMethod, "bind_class", umethod_bind_class, 1);
}