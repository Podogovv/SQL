create table brands (
    brand_id     serial primary key,
    brand_name   text not null
);

create table product_lines (
    line_id      serial primary key,
    line_name    text not null
);

create table product_classes (
    class_id     serial primary key,
    class_name   text not null
);

create table product_sizes (
    size_id      serial primary key,
    size_name    text not null
);

create table countries (
    country_id serial primary key,
    country_name text not null
);

create table states (
    state_id serial primary key,
    state_name text not null,
    country_id int not null,
    foreign key (country_id) references countries(country_id)
);

create table postcodes (
    postcode int primary key,
    state_id int not null,
    foreign key (state_id) references states(state_id)
);

create table addresses (
    address_id serial primary key,
    street_address text not null,
    postcode int not null,
    foreign key (postcode) references postcodes(postcode)
);

create table industries (
    industry_id serial primary key,
    industry_name text not null
);

create table jobs (
    job_id serial primary key,
    job_title text not null,
    industry_id int,
    foreign key (industry_id) references industries(industry_id)
);
create table products (
    product_id       int primary key,
    brand_id         int not null,
    line_id          int not null,
    class_id         int not null,
    size_id          int not null,
    list_price       numeric(10,2) not null,
    standard_cost    numeric(10,2) not null,

    constraint fk_products_brand
        foreign key (brand_id) references brands (brand_id),

    constraint fk_products_line
        foreign key (line_id) references product_lines (line_id),

    constraint fk_products_class
        foreign key (class_id) references product_classes (class_id),

    constraint fk_products_size
        foreign key (size_id) references product_sizes (size_id)
);

create table customers (
    customer_id int primary key,
    first_name text not null,
    last_name text not null,
    gender text not null,
    dob date not null,
    
    job_id int,
    wealth_segment text not null,
    
    deceased boolean not null default false,
    owns_car boolean not null default false,

    address_id int not null,
    property_valuation int not null,

    foreign key (job_id) references jobs(job_id),
    foreign key (address_id) references addresses(address_id)
);

create table transactions (
    transaction_id    int primary key,
    product_id        int not null,
    customer_id       int not null,
    transaction_date  date not null,
    online_order      boolean not null,
    order_status      text not null,

    constraint fk_transactions_product
        foreign key (product_id) references products (product_id),

    constraint fk_transactions_customer
        foreign key (customer_id) references customers (customer_id)
);
