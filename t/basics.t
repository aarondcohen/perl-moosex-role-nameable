#!/usr/bin/env perl

use strict;
use warnings qw(all);

use FindBin ();
use lib "$FindBin::Bin/../lib";

use Test::Most tests => 7;

use_ok 'MooseX::Role::Nameable';

{
	package Bar;
	use Moose;
	with 'MooseX::Role::Nameable' => {name => 'name'};
	__PACKAGE__->meta->make_immutable;
}
{
	package Bar::Foo;
	use Moose;
	with 'MooseX::Role::Nameable' => {name => 'name'};
	__PACKAGE__->meta->make_immutable;
}
{
	package Foo::SomeDeep::LongPackageName;
	use Moose;
	with
		'MooseX::Role::Nameable' => {name => 'name'},
		'MooseX::Role::Nameable' => {name => 'parent', regex => qr{([^:]*)::[^:]*$}};
	__PACKAGE__->meta->make_immutable;
}
{
	package Foo::XXLPackageBIGNameACRONYM;
	use Moose;
	with
		'MooseX::Role::Nameable' => {name => 'name'};
	__PACKAGE__->meta->make_immutable;
}

is(Bar->name, 'bar', 'nameable works with unnested classes');
is(Bar::Foo->name, 'foo', 'nameable uses the most nested class by default');
is(Foo::SomeDeep::LongPackageName->name, 'long_package_name', 'nameable splits camel-case with underscores');
is(Foo::SomeDeep::LongPackageName->parent, 'some_deep', 'nameable can alter where to find the name');
is(Foo::XXLPackageBIGNameACRONYM->name, 'xxl_package_big_name_acronym', 'nameable splits acronyms from words with underscores');
is(Bar->new->name, 'bar', 'nameable works with instances');
