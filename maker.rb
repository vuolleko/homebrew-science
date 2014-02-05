require 'formula'

class Maker < Formula
  homepage 'http://www.yandell-lab.org/software/maker.html'

  @@key = nil # Unique user ID
  url "http://yandell.topaz.genetics.utah.edu/maker_downloads/#{@@key}/maker-2.28.tgz"
  sha1 'e8180672fc39bd486b93bfc9a5c68ab05d83337a'

  devel do
    url "http://yandell.topaz.genetics.utah.edu/maker_downloads/#{@@key}/maker-2.30p-beta.tgz"
    sha1 '0b4d0b60aa1ed589bb5b43245509a9428c0acfa5'
  end

  depends_on 'augustus' => :recommended
  depends_on 'blast'
  depends_on 'exonerate'
  depends_on 'genemarks' => :optional
  depends_on :mpi => :optional
  depends_on 'repeatmasker'
  depends_on 'snap'

  depends_on 'Bio::Perl' => :perl
  depends_on 'Bit::Vector' => :perl
  depends_on 'DBD::SQLite' => :perl
  depends_on 'DBI' => :perl
  depends_on 'File::Which' => :perl
  depends_on 'IO::All' => :perl
  depends_on 'IO::Prompt' => :perl
  depends_on 'Inline' => :perl
  depends_on 'Perl::Unsafe::Signals' => :perl
  depends_on 'PerlIO::gzip' => :perl
  depends_on 'Proc::ProcessTable' => :perl
  depends_on 'forks' => :perl
  depends_on 'forks::shared' => :perl
  depends_on 'threads' => :perl

  def install
    cd 'src' do
      system 'yes "" |perl Build.PL'
      system *%w[./Build install]
    end
    libexec.install Dir['*']
    bin.install_symlink '../libexec/bin/maker'
  end

  def caveats; <<-EOS.undent
    Set the PERL5LIB environment variable:
      export PERL5LIB=#{opt_prefix/'libexec/lib'}:#{opt_prefix/'libexec/perl/lib'}:${PERL5LIB}
    EOS
  end

  test do
    system 'maker --version'
  end
end
