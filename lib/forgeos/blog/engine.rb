require 'forgeos/core'
require 'forgeos/cms'
module Forgeos
  module Blog
    class Engine < Rails::Engine
      paths['config/locales'] << 'config/locales/**'
    end
  end
end
