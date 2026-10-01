use application 'polytope';

use IO::File;
use File::Basename;

# ------------------------------------------------------------
# Usage
# ------------------------------------------------------------
if (@ARGV < 1) {
    die "Usage: polymake --script integer_points_output.pl <filename.lp>\n";
}

my $input_file = $ARGV[0];

# ------------------------------------------------------------
# Output file names
# ------------------------------------------------------------
my ($filename, $dirs, $suffix)
    = fileparse($input_file, qr/\.[^.]*/);

my $all_points_file =
    "${filename}_integer_points.csv";

my $hull_vertices_file =
    "${filename}_integer_hull_vertices.csv";

# ------------------------------------------------------------
# Read LP file
# ------------------------------------------------------------
my $P = lp2poly($input_file);

# ------------------------------------------------------------
# Check boundedness
# ------------------------------------------------------------
if (!$P->BOUNDED) {
    die "The polyhedron is unbounded. "
      . "It may contain infinitely many integer points.\n";
}

# ------------------------------------------------------------
# Variable names
# ------------------------------------------------------------
my @var_labels = @{$P->COORDINATE_LABELS};

if (@var_labels && $var_labels[0] eq 'inhomog_var') {
    shift @var_labels;
}

# ============================================================
# PART 1: Enumerate all feasible integer points
# ============================================================

my $integer_points = $P->LATTICE_POINTS;

my $fh_all = IO::File->new($all_points_file, "w")
    or die "Could not open '$all_points_file': $!\n";

print $fh_all join(",", @var_labels) . "\n";

for (my $i = 0; $i < $integer_points->rows; ++$i) {

    my $row = $integer_points->row($i);
    my @coords = @$row;

    # Remove homogeneous coordinate
    my $h = shift @coords;

    # Usually h = 1 for lattice points
    @coords = map { $_ / $h } @coords if $h != 1;

    print $fh_all join(",", @coords) . "\n";
}

$fh_all->close();

# ============================================================
# PART 2: Construct integer hull
# ============================================================

my $integer_hull =
    new Polytope<Rational>(
        POINTS            => $integer_points,
        COORDINATE_LABELS => $P->COORDINATE_LABELS
    );

# Vertices of the integer hull
my $vertices = $integer_hull->VERTICES;

my $fh_vertices =
    IO::File->new($hull_vertices_file, "w")
    or die "Could not open '$hull_vertices_file': $!\n";

print $fh_vertices join(",", @var_labels) . "\n";

my $num_vertices = 0;

for (my $i = 0; $i < $vertices->rows; ++$i) {

    my $row = $vertices->row($i);
    my @coords = @$row;

    # Homogeneous coordinate
    my $h = shift @coords;

    # Since the integer hull is bounded, h should be > 0
    next if $h == 0;

    @coords = map { $_ / $h } @coords;

    print $fh_vertices join(",", @coords) . "\n";

    ++$num_vertices;
}

$fh_vertices->close();

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
print "\n";
print "Polyhedron bounded: YES\n";
print "Number of feasible integer points: ",
      $integer_points->rows, "\n";

print "Number of integer-hull vertices:   ",
      $num_vertices, "\n";

print "\n";
print "All integer points saved to:\n";
print "  $all_points_file\n";

print "Integer-hull vertices saved to:\n";
print "  $hull_vertices_file\n";