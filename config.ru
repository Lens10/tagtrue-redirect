require 'rack/rewrite'
use Rack::Rewrite do
  r301      %r{/(.*)},   'https://staging.datatrue.com/$1'
end

run lambda { |env| [301, {'Location'=>'https://staging.datatrue.com/'}, StringIO.new("")] }

