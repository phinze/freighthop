interactor :off

guard :shell do
  watch(%r{local_modules/.*}) { `librarian-puppet install --verbose` }
end
