When /^I get help for "([^"]*)"$/ do |app_name|
  @app_name = app_name
  step %(I run `#{app_name} help`)
end

Then /^the output should contain today's date$/ do
  step "the output should contain \"#{Date.today.to_s}\""
end
