package MooseX::Role::Nameable;
use MooseX::Role::Parameterized;

my %CACHED_NAMES;

parameter name => (isa  => 'Str', required => 1);
parameter regex => ();

role {
	my $p = shift;

	my $name = $p->name;
	my $regex = $p->regex || '([^:]*)$';
	$regex = qr{$regex};

	method $name => sub {
		my $class = shift;
		$class = ref $class || $class;

		my $n = $CACHED_NAMES{"$class\::$name"};
		unless (defined $n) {
			($n) = $class =~ $regex;
			$n =~ s/([[:lower:]])([[:upper:]])/$1\_$2/g;
			$n =~ s/([[:upper:]])([[:upper:]][[:lower:]])/$1\_$2/g;
			$n = $CACHED_NAMES{"$class\::$name"} = lc $n;
		}
		return $n;
	};
};

1;
