module DoorkeeperMongodb
  module Compatible
    extend ActiveSupport::Concern

    module ClassMethods
      def transaction(_ = {}, &_block)
        yield
      end

      def table_exists?(*)
        true # Doorkeeper deprecated this
      end

      # Mongoid::Contextual::Mongo#last no longer guarantee order
      # http://www.rubydoc.info/github/mongoid/mongoid/Mongoid%2FContextual%2FMongo:last
      def last
        asc(:id).last
      end
    end

    def transaction(options = {}, &block)
      self.class.transaction(options, &block)
    end

    def lock!(_ = true)
      reload if persisted?
      self
    end
  end
end
