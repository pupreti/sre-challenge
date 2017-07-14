name 'sre-challenge'
maintainer 'Prakash upreti'
maintainer_email 'latitudemt8848@gmail.com'
license 'All Rights Reserved'
description 'Installs/Configures secure webserver'
long_description 'Installs/Configures secure webserver'
version '0.1.0'
chef_version '>= 12.1' if respond_to?(:chef_version)

depends 'iptables'
depends 'ssl_certificate'
