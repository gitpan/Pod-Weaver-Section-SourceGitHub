
use strict;
use warnings;



use ExtUtils::MakeMaker 6.11;



my %WriteMakefileArgs = (
                       'test' => {
                                   'TESTS' => 't/*.t'
                                 },
                       'NAME' => 'Pod::Weaver::Section::SourceGitHub',
                       'DISTNAME' => 'Pod-Weaver-Section-SourceGitHub',
                       'CONFIGURE_REQUIRES' => {
                                                 'ExtUtils::MakeMaker' => '6.11'
                                               },
                       'AUTHOR' => 'Michael Schout <mschout@cpan.org>',
                       'BUILD_REQUIRES' => {},
                       'ABSTRACT' => 'Add SOURCE pod section for a github repository',
                       'EXE_FILES' => [],
                       'VERSION' => '0.51',
                       'PREREQ_PM' => {
                                        'Module::Signature' => '0',
                                        'Test::More' => '0',
                                        'Pod::Weaver::Role::Section' => '0',
                                        'Socket' => '0',
                                        'Moose::Autobox' => '0',
                                        'Moose' => '0'
                                      },
                       'LICENSE' => 'perl'
                     );


delete $WriteMakefileArgs{LICENSE}
  unless eval { ExtUtils::MakeMaker->VERSION(6.31) };

WriteMakefile(%WriteMakefileArgs);



