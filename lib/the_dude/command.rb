module TheDude
  class Command
    # [TheDude::Expression] The expression for this command
    attr_reader :expression

    # [String | Proc | Block] The answer for this command
    attr_accessor :answer

    # Initializes a new command.
    #
    # An instance is created to hold the details of the command and the command
    # is registered in TheDude.commands using the provided key. The answer can
    # be a string, proc or block. If both a string/proc and block are passed,
    # the block will take precedence.
    #
    # @example
    #
    #   command = TheDude::Command.new 'hello', 'hello'
    #   TheDude.commands['hello'] == command # true
    #
    #   TheDude::Command.new 'hello' do
    #     puts 'hello'
    #     puts 'how are you?'
    #   end
    #
    # @param [String | Regexp] expression  the question to ask
    # @param [String | Proc]   answer      the answer to the question
    #
    # @return [TheDude::Command]
    def initialize expression, answer=nil, &block_answer
      @expression = Expression.new(expression)
      @answer = block_answer || answer

      TheDude.register_command self
    end

    # Asks the question with the specified arguments. If the answer is a string
    # it is returned. If it is a proc or block it is evaluated with the passed
    # parameters.
    def ask *args
      begin
        if answer.kind_of?(Proc)
          TheDude::Dsl.new.instance_exec(*args, &answer)
        else
          answer
        end
      rescue SystemExit
        exit
      rescue Interrupt
        TheDude.say 'Fine, i\'ll leave it then'
      rescue Exception => e
        TheDude.complain "Man, what are you doing? Look what you just did\n
        #{e.class}
        #{e.message}
        #{e.backtrace}
        At least you didn't pee on my rug I guess
        "
      end
    end
  end
end
