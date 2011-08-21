name              'haskell'
version           '0.1'
depends           %w{build-essential}
description       'This downloads and installs the Haskell Platform.'
maintainer        'Eric Rochester'
maintainer_email  'erochest@gmail.com'
license           'Apache 2.0'

%w{ ubuntu }.each do |os|
  supports os
end
