Feature: Basic interaction with the Dude

  Scenario: App just runs
    When I get help for "dude"
    Then the exit status should be 0

  Scenario: Asking a question
    When I run `dude why?`
    Then the output should contain "because"

  Scenario: Asking a question that requires running another command
    When I run `dude date`
    Then the output should contain today's date
