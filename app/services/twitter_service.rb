class TwitterService
 def initialize
  @client = Twitter::REST::Client.new do |config|
    config.consumer_key = "XzENvqqEUsrDEZc3orzANWcaU"
    config.consumer_secret = "NVg2cFASyQ4PvH4FWGDlPaC7wXCIQ08LWZjyBR7nrPvzL7XOLb"
    config.access_token = "777470408371023872-ijIopeQkM5r6VVF2QOZZje0cGQGcQ0P"
    config.access_token_secret = "y1iOt15uTUkxXFKsCSO4a7XotodoKKA6J4NmfqR1VolAv"
  end
 end

 def tweet(message)
  @client.update(message)
 end
end