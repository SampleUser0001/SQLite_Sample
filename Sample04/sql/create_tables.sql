

create table layout_master (
    id integer,
    default_order integer,
    value text,
    
    primary key(id)
);

create table user_layout(
    layout_id integer,
    user_id text,
    user_order integer,

    primary key(layout_id, user_id, user_order),
    foreign key (layout_id) references layout_master(id)
);
