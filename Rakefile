require "bundler/gem_tasks"

desc 'run librarian-puppet to update puppet modules from Puppetfile'
task :librarian do
  sh "librarian-puppet clean --verbose"
  sh "librarian-puppet install --strip-dot-git --verbose"
end
