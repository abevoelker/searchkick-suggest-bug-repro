# Steps to reproduce:

```
git clone https://github.com/abevoelker/searchkick-suggest-bug-repro.git
cd searchkick-suggest-bug-repro
docker build . -t foo
docker run -p 9200:9200 --rm foo
bundle
bundle exec rake db:create db:migrate
bundle exec rake searchkick:reindex CLASS=Product
bundle exec rails runner "Product.search '*', suggest: true"
```

# You should see output similar to this from the last step:

```
/home/abe/.gem/ruby/2.2.3/gems/searchkick-1.1.2/lib/searchkick/query.rb:76:in `rescue in execute': [400] {"error":{"root_cause":[{"type":"illegal_argument_exception","reason":"No mapping found for field [title.suggest]"}],"type":"search_phase_execution_exception","reason":"all shards failed","phase":"query","grouped":true,"failed_shards":[{"shard":0,"index":"products_development_20160101002945815","node":"x_Ols4UiRyuexXv997svuQ","reason":{"type":"illegal_argument_exception","reason":"No mapping found for field [title.suggest]"}}]},"status":400} (Searchkick::InvalidQueryError)
        from /home/abe/.gem/ruby/2.2.3/gems/searchkick-1.1.2/lib/searchkick/query.rb:54:in `execute'
        from /home/abe/.gem/ruby/2.2.3/gems/searchkick-1.1.2/lib/searchkick/index.rb:120:in `search_model'
        from /home/abe/.gem/ruby/2.2.3/gems/searchkick-1.1.2/lib/searchkick/model.rb:22:in `searchkick_search'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/runner.rb:62:in `<top (required)>'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/runner.rb:62:in `eval'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/runner.rb:62:in `<top (required)>'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/commands_tasks.rb:123:in `require'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/commands_tasks.rb:123:in `require_command!'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/commands_tasks.rb:90:in `runner'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands/commands_tasks.rb:39:in `run_command!'
        from /home/abe/.gem/ruby/2.2.3/gems/railties-4.2.3/lib/rails/commands.rb:17:in `<top (required)>'
        from bin/rails:4:in `require'
        from bin/rails:4:in `<main>'
```

