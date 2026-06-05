module Rails
  module Guarddog
    class Railtie < Rails::Railtie
      rake_tasks do
        load "tasks/guarddog.rake"
      end

      config.guarddog = Configuration.new
    end
  end
end
