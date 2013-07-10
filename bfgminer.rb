require 'formula'

class Bfgminer < Formula
    homepage 'https://github.com/luke-jr/bfgminer'
    head 'https://github.com/luke-jr/bfgminer.git', :branch => 'bfgminer'
    url 'https://github.com/luke-jr/bfgminer.git', :tag => 'bfgminer-3.1.2'
    version '3.1.2'
    
    depends_on 'autoconf' => :build
    depends_on 'automake' => :build
    depends_on 'libtool' => :build
    depends_on 'pkg-config' => :build
    depends_on 'uthash'
    depends_on 'curl'
    depends_on 'jansson'
    
    def install
        system "./autogen.sh"
        system "./configure", "--disable-debug", "--disable-dependency-tracking",
        "--prefix=#{prefix}",
        "PKG_CONFIG_PATH=/usr/local/opt/curl/lib/pkgconfig:/usr/local/opt/jansson/lib/pkgconfig",
        "--enable-scrypt"
        system "make", "install"
    end

    def patches
      unless build.head?
        "https://github.com/luke-jr/bfgminer/commit/4174a1d0589bb94c65e186d0c10142ba8f2176ae.patch"
      end
    end

    test do
        system "bfgminer"
    end
end