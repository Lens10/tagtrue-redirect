require 'rack/rewrite'

use Rack::Rewrite do
  r301 %r{/(.*)}, 'https://staging.datatrue.com/$1', host: 'staging.tagtrue.com',
                  headers: {'Cache-Control' => 'public, max-age=31536000', 'Content-Type' => 'text/plain' }

  r301 %r{/(.*)}, 'https://datatrue.com/$1',
                  headers: {'Cache-Control' => 'public, max-age=31536000', 'Content-Type' => 'text/plain' }
end

run lambda { |env| [301, {'Location'=>'https://datatrue.com/'}, StringIO.new("")] }
