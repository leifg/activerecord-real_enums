module ActiveRecord
  module RealEnums
    module Models
      module Postgresql
        extend ActiveSupport::Concern

        def self.included(base)
          base.extend ClassMethods
        end

        module ClassMethods
          def real_enum(name, options)
            sql = "SELECT unnest(enum_range(NULL::#{options.fetch(:type)}))"

            values = ::ActiveRecord::Base.
              connection.
              execute(sql).
              map { |e| e["unnest"] }

            validates_inclusion_of(name, in: values)
          end
        end
      end
    end
  end
end

class ActiveRecord::Base
  include ActiveRecord::RealEnums::Models::Postgresql
end
