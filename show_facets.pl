use application 'polytope';

# 1. Read LP and find integer lattice points
my $rel = lp2poly('knapsackex1.lp');
my $pts = new Polytope<Rational>($rel)->LATTICE_POINTS;

print "--- RAW FEASIBLE INTEGER POINTS ---\n";
print $pts;

my $ip_poly = new Polytope(POINTS=>$pts, COORDINATE_LABELS=>$rel->COORDINATE_LABELS);

# 3. Print all human-readable integer facets
print "\n-FACETS ---\n";
print_constraints($ip_poly);