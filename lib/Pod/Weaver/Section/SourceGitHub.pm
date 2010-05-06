package Pod::Weaver::Section::SourceGitHub;
BEGIN {
  $Pod::Weaver::Section::SourceGitHub::VERSION = '0.53';
}

# ABSTRACT: Add SOURCE pod section for a github repository

use Moose;

with 'Pod::Weaver::Role::Section';

use Moose::Autobox;


sub weave_section {
    my ($self, $document, $input) = @_;

    my $zilla = $input->{zilla} or return;

    my $meta = eval { $zilla->distmeta }
        or die "no distmeta data present";

    # pull repo out of distmeta resources.
    my $repo = $meta->{resources}{repository} or return;

    return unless $repo =~ /github\.com/;

    my $clonerepo = $repo;

    # fix up clone repo url
    if ($clonerepo =~ m#^http://#) {
        $clonerepo =~ s#^http://#git://#;
    }
    if ($clonerepo !~ /\.git$/) {
        $clonerepo .= '.git';
    }

    my $text =
        "You can contribute or fork this project via github:\n".
        "\n".
        "$repo\n";

    # if repo differs from the clone repo, add clone command.
    if ($clonerepo ne $repo) {
        $text .= "\n".
                 " git clone $clonerepo";
    }

    $document->children->push(
        Pod::Elemental::Element::Nested->new({
            command => 'head1',
            content => 'SOURCE',
            children => [
                Pod::Elemental::Element::Pod5::Ordinary->new({content => $text}),
            ],
        }),
    );
}

no Moose;
1;



=pod

=head1 NAME

Pod::Weaver::Section::SourceGitHub - Add SOURCE pod section for a github repository

=head1 VERSION

version 0.53

=head1 SYNOPSIS

in C<weaver.ini>:

 [SourceGitHub]

=head1 OVERVIEW

This section plugin will produce a hunk of Pod that gives the github URL for
your module, as well as instructions on how to clone the repository.

=head1 METHODS

=head2 weave_section

adds the C<SOURCE> section.

=head1 AUTHOR

  Michael Schout <mschout@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2010 by Michael Schout.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=head1 SOURCE

You can contribute or fork this project via github:

http://github.com/mschout/pod-weaver-section-sourcegithub

 git clone git://github.com/mschout/pod-weaver-section-sourcegithub.git

=head1 BUGS

Please report any bugs or feature requests to bug-pod-weaver-section-sourcegithub@rt.cpan.org or through the web interface at:
 http://rt.cpan.org/Public/Dist/Display.html?Name=Pod-Weaver-Section-SourceGitHub

=cut


__END__

