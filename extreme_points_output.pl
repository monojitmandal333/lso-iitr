use application 'polytope';

use IO::File;
use File::Basename;

# ------------------------------------------------------------
# Usage check
# ------------------------------------------------------------
if (@ARGV < 1) {
    die "Usage: polymake --script extreme_points_output.pl <filename.lp>\n";
}

my $input_file = $ARGV[0];

# ------------------------------------------------------------
# Output file name
# ------------------------------------------------------------
my ($filename, $dirs, $suffix)
    = fileparse($input_file, qr/\.[^.]*/);

my $output_file = "${filename}_extreme_points.csv";

# ------------------------------------------------------------
# Read LP file
# ------------------------------------------------------------
my $P = lp2poly($input_file);

# ------------------------------------------------------------
# Variable names
# ------------------------------------------------------------
my @var_labels = @{$P->COORDINATE_LABELS};

# Remove homogeneous-coordinate label
if (@var_labels && $var_labels[0] eq 'inhomog_var') {
    shift @var_labels;
}

# ------------------------------------------------------------
# Generator representation
#
# In polymake, VERTICES contains the homogeneous generators.
#
# First coordinate > 0 : ordinary vertex
# First coordinate = 0 : ray
# ------------------------------------------------------------
my $generators = $P->VERTICES;

# ------------------------------------------------------------
# Open output CSV
# ------------------------------------------------------------
my $fh = IO::File->new($output_file, "w")
    or die "Could not open file '$output_file': $!\n";

print $fh "Point_Type," . join(",", @var_labels) . "\n";

my $num_vertices = 0;
my $num_rays     = 0;

# ------------------------------------------------------------
# Separate vertices and rays
# ------------------------------------------------------------
for (my $i = 0; $i < $generators->rows; ++$i) {

    my $row = $generators->row($i);
    my @coords = @$row;

    # First entry is the homogeneous coordinate
    my $h = shift @coords;

    if ($h == 0) {

        # Genuine ray
        print $fh "Ray," . join(",", @coords) . "\n";
        ++$num_rays;

    }
    else {

        # Ordinary vertex
        # Normalize homogeneous coordinates if necessary
        @coords = map { $_ / $h } @coords;

        print $fh "Vertex," . join(",", @coords) . "\n";
        ++$num_vertices;
    }
}

$fh->close();

# ------------------------------------------------------------
# Summary
# ------------------------------------------------------------
print "\n";
print "Polyhedron bounded: ",
      ($P->BOUNDED ? "YES" : "NO"), "\n";

print "Number of vertices: $num_vertices\n";
print "Number of rays:     $num_rays\n";
print "Output saved to:    $output_file\n";