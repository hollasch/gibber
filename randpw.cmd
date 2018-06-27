@ perl -Sx %0 %*
@ goto :eof
#!perl

open DICT, "<" . "en.words"
    or die "Couldn't open dictionary.\n";

# Slurp in the dictionary.

@words = <DICT>;


# This routine returns a random word.

sub randword
{
    $_ = $words [int(rand() * $#words)];
    chomp;
    $_
}



# Generate ten synthetic words

for (my $row=1;  $row <= 25;  ++$row)
{
    my $synthlen;

    for (my $column=1;  $column <= 8;  ++$column)
    {
        my $synthword = '';

        # Each synthetic word is composed of two random fragments.

        for (my $frag=1;  $frag <= 2;  ++$frag)
        {
            my $word, $wordlen;

            do {
                $word    = randword();
                $wordlen = length $word;
            } while ($wordlen < 5);

            my $fraglen = 3 + ($wordlen > 8);
            ++$fraglen if (rand() < 0.5);

            $synthword .= substr ($word, int(rand() * ($wordlen-$fraglen+1)), $fraglen);
        }

        if ($column > 1)
        {   print (' ' x (12 - $synthlen));
        }
 
        print $synthword;

        $synthlen = length $synthword;
    }

    print "\n";
}
