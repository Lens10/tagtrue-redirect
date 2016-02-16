require 'rack/rewrite'
use Rack::Rewrite do
  r301      %r{/(.*)},   'https://staging.datatrue.com/$1', host: 'staging.tagtrue.com'
  r301      %r{/(.*)},   'https://datatrue.com/$1'
end

run lambda { |env| [301, {'Location'=>'https://datatrue.com/'}, StringIO.new("")] }

