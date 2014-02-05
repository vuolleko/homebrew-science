require 'formula'

class Genemarks < Formula
  homepage 'http://opal.biology.gatech.edu/GeneMark/'
  version '2.5p'
  @@key = nil # Unique user ID
  if OS.mac?
    url "http://topaz.gatech.edu/GeneMark/tmp/GMtool_#{@@key}/genemark_suite_macosx.tar.gz"
    sha1 'ad1f89066d44ace9fb6f68a26cdd8b20e1e41c5c'
  elsif OS.linux?
    url "http://topaz.gatech.edu/GeneMark/tmp/GMtool_#{@@key}/genemark_suite_linux64.tar.gz"
    sha1 'bfed1a716a55793dc94286bd816e29f6c43805b5'
  else
    raise 'Unknown operating system'
  end

  conflicts_with 'graphicsmagick',
    :because => "both install #{HOMEBREW_PREFIX}/bin/gm"

  def install
    libexec.install Dir['gmsuite/*']
    bin.install_symlink '../libexec/gm'
  end

  def caveats
    <<-EOS.undent
      Register for a license:
        http://opal.biology.gatech.edu/GeneMark/license_download.cgi
      Download the key file "gm_key" into the home directory:
        curl http://topaz.gatech.edu/GeneMark/tmp/GMtool_#{@@key}/gm_key >~/.gm_key
    EOS
  end

  test do
    system 'gm 2>&1 |grep -q GeneMark'
  end
end
