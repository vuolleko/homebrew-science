require 'formula'

class AllpathsLg < Formula
  homepage 'http://www.broadinstitute.org/software/allpaths-lg/blog/'
  url 'ftp://ftp.broadinstitute.org/pub/crd/ALLPATHS/Release-LG/latest_source_code/allpathslg-48686.tar.gz'
  sha1 '21780e413eed7041ef7c6bfcd16ec6258d0264b9'

  fails_with :clang do
    build 500
    cause 'You must compile this with g++ 4.7 or higher.'
  end

  fails_with :gcc do
    build 5666
    cause 'You must compile this with g++ 4.7 or higher.'
  end

  def install
    system './configure', '--disable-debug', '--disable-dependency-tracking',
      "--prefix=#{prefix}"
    system 'make', 'install'
  end

  test do
    system "#{bin}/RunAllPathsLG", '--version'
  end
end
