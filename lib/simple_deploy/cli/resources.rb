require 'trollop'

module SimpleDeploy
  module CLI

    class Resources
      include Shared

      def show
        opts = Trollop::options do
          version SimpleDeploy::VERSION
          banner <<-EOS

Show resources of a stack.

simple_deploy resources -n STACK_NAME -e ENVIRONMENT

EOS
          opt :help, "Display Help"
          opt :environment, "Set the target environment", :type => :string
          opt :log_level, "Log level:  debug, info, warn, error", :type    => :string,
                                                                  :default => 'warn'
          opt :name, "Stack name to manage", :type => :string
        end

        CLI::Shared.valid_options? :provided => opts,
                                   :required => [:environment, :name]

        config = Config.new.environment opts[:environment]

        logger = SimpleDeployLogger.new :log_level => opts[:log_level]

        stack = Stack.new :environment => opts[:environment],
                          :name        => opts[:name],
                          :config      => config,
                          :logger      => logger

        jj stack.resources
      end

      def command_name
        short_class_name
      end

      def command_summary
        'Show resources of a stack'
      end

    end

  end
end
