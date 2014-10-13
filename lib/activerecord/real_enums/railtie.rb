module ActiveRecord
  module RealEnums
    require "rails"
    class Railtie < Rails::Railtie
      initializer "real_enums.insert_into_active_record" do
        ActiveSupport.on_load :active_record do
          case ::ActiveRecord::Base.connection
          when ActiveRecord::ConnectionAdapters::PostgreSQLAdapter
            require "activerecord/real_enums/models/postgresql"
            ::ActiveRecord::Base.send :include, ActiveRecord::RealEnums::Models::Postgresql
          else
            warn("enum type not supported in this DB type")
          end
        end
      end
    end
  end
end
