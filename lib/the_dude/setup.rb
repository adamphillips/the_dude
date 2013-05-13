# Sets up default commands and variables
TheDude::Variable.new(:number, /\d+/).register
TheDude::Variable.new(:operator, /[+\-\/\*]/).register
TheDude::Variable.new(:url, /\S+/).register
TheDude::Variable.new(:search_query, /\S+/).register

TheDude::Command.new 'enough', ->{ exit }
TheDude::Command.new 'enuff', ->{ exit }

TheDude::Command.new 'yo', 'yo mofo!'
TheDude::Command.new 'time', ->{ `date` }
TheDude::Command.new 'date', ->{ `date "+%Y-%m-%d"` }
TheDude::Command.new 'why?', 'because'
TheDude::Command.new 'wassup', -> { exec 'top' }
TheDude::Command.new /what is :number :operator :number/, ->(v1, op, v2){ eval "#{v1.to_f} #{op} #{v2.to_i}" }
TheDude::Command.new /^fetch (.*)/, ->(url){ system "lynx #{url}"}
TheDude::Command.new /^google :search_query/, ->(query){ `open "https://www.google.co.uk/search?q=#{query}"` }
TheDude::Command.new /^show me pictures of (.*)/, ->(query){ `open "https://www.google.co.uk/search?q=#{query}&tbm=isch"` }
TheDude::Command.new /source for :url/, ->(url){ `curl #{url} | highlight --syntax html -O xterm256`  }
TheDude::Command.new /headers for :url/, ->(url){ `curl -I #{url}`  }

