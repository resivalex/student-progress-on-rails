module Requests
  module JsonHelpers
    def json
      Oj.load response.body
    end
  end
end