module SSHKit

  class Configuration

    attr_writer :command_map
    attr_accessor :output, :backend

    def initialize
      @output  = SSHKit::Formatter::Pretty.new($stdout)
      @backend = SSHKit::Backend::Netssh
    end

    def command_map
      @command_map ||= begin
        Hash.new do |hash, command|
          if %w{if test time}.include? command.to_s
            hash[command] = command.to_s
          else
            hash[command] = "/usr/bin/env #{command}"
          end
        end
      end
    end

  end

end