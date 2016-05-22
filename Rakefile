task :default => :web

desc "Compile parser.pegjs browser version"
task :web do
  sh "pegjs -e pl0 models/parse.pegjs public/parser.js"
end

desc "Compile parser.pegjs node version"
task :node do
  sh "pegjs models/parser.pegjs models/parsernode.js"
end

