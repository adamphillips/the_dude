Feature: Reading from ~/.duderc
It should be possible to configure the dude from a duderc file

  Scenario: File doesn't exist should still work
    When I run `dude`
    Then the exit status should be 0

  #Scenario: File containing a question definition
    #Given a file named "~/.duderc" with:
      #"""
      #command "another question" do
        #"another answer"
      #end
      #"""
    #When I run `dude another question`
    #Then the output should contain "another answer"

  #Scenario: File containing a question definition
    #Given a file named "~/.duderc" with:
      #"""
      #command "say something" do
        #`echo "hello"`
      #end
      #"""
    #When I run `dude another question`
    #Then the output should contain exactly "hello"

