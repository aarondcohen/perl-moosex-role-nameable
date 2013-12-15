use strict;
use warnings;

use ExtUtils::MakeMaker;
use ExtUtils::MakeMaker::CPANfile;

WriteMakefile(
	NAME                => 'MooseX::Role::Nameable',
	AUTHOR              => q{Aaron Cohen <acohen@shutterstock.com>},
	VERSION_FROM        => 'lib/MooseX/Role/Nameable.pm',
	ABSTRACT            => 'automatic class short names for the class',
);
