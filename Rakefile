require 'shellwords'

task :i => :test do
  Dir['*.gemspec'].each do |gemspec|
    sh %{gebuin #{gemspec.shellescape}}
  end
end

task :test do
  sh %{bin/sid-csv -f csv test/ietf-system.csv | diff - test/ietf-system.sid}
  sh %{bin/sid-csv -t csv test/ietf-system.sid | diff - test/ietf-system.csv}
end
