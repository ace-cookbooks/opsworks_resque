name             'opsworks_resque'
maintainer       'Ace of Sales'
maintainer_email 'cookbooks@aceofsales.com'
license          'Apache 2.0'
description      'Manages legacy resque on opsworks'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends 'eye'

recipe 'opsworks_resque', 'Launches resque'
recipe 'opsworks_resque::restart', 'Restarts resque'
recipe 'opsworks_resque::stop', 'Stops resque'
