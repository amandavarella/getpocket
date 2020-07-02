require "uri"
require "net/http"
require "json"
require 'dotenv'
Dotenv.load

GET_POCKET_CONSUMER_KEY_ENVATO = ENV['ENVATO_CONSUMER_KEY']
GET_POCKET_ACCESS_TOKEN_ENVATO = ENV['ENVATO_ACCESS_TOKEN']
GET_POCKET_CONSUMER_KEY_GOOGLE = ENV['GOOGLE_CONSUMER_KEY']
GET_POCKET_ACCESS_TOKEN_GOOGLE = ENV['GOOGLE_ACCESS_TOKEN']

puts GET_POCKET_CONSUMER_KEY_ENVATO
puts GET_POCKET_ACCESS_TOKEN_ENVATO
puts GET_POCKET_CONSUMER_KEY_GOOGLE
puts GET_POCKET_ACCESS_TOKEN_GOOGLE


def get_envato_items

    url = URI("https://getpocket.com/v3/get?consumer_key=#{GET_POCKET_CONSUMER_KEY_ENVATO}&access_token=#{GET_POCKET_ACCESS_TOKEN_ENVATO}")
    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Basic Og=="
    request["Cookie"] = "PHPSESSID=cc44699fef0dca60b1236c6799e20f98; sess_guid=14agfd13p82dtD2c93TGy5dRcpA2p37b2ePj26V1e1b241y8a6270w08ReDjBafr; sess_start_time=1593603149; AUTH_BEARER_default=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzUxMiJ9.eyJpYXQiOjE1OTM2NjMwOTcsImp0aSI6InEzK2dGVVwvMkU3ek84aW9LRzhrT0JCNzBCNitOWWpudXhmVXk4bFdpN3VzPSIsImlzcyI6ImdldHBvY2tldC5jb20iLCJuYmYiOjE1OTM2NjMwOTcsImV4cCI6MTU5MzY2NjY5NywiZGF0YSI6Il9zZjJfYXR0cmlidXRlc3xhOjA6e31fc3ltZm9ueV9mbGFzaGVzfGE6MDp7fV9zZjJfbWV0YXxhOjM6e3M6MTpcInVcIjtpOjE1OTM2NjMwOTc7czoxOlwiY1wiO2k6MTU5MzY2MjI2MztzOjE6XCJsXCI7czoxOlwiMFwiO30ifQ.MUXacEmuh-EBsY3iBgfpyguPC5haHILeEVmwB3ux4j3DzvtuuHliIV5uCl3KoihHjgPcbhfjFN7HDH9U2NN_fVqLLX2UIQ5TWnlFrW0je4GcOBa6_2qHATN2zVdg_F8dbJBg-h95iH3e5y6rrNXKVfKZFJixLiMvK4Hci1eSEDLcFbFDGI1S2162PWuY0Dtp2OwsxnZ8rF4HtTMLvGv3mM70FVWSQQJETqkcjdSpXLh8bpCadO-U4G-31LHEtsAPgtKZTwk3hGGp5YSjVe1LJ0cy73HTjVAkUBC8PVBWDjXXzqZurCEb_eco-0fDUBZcjS6aWHCr4eHC0oD76LeH6A"

    response = https.request(request)
    puts response.read_body
end

def get_urls(envato_items)

    my_hash = JSON.parse(envato_items.read_body)
    list = my_hash["list"]
    list_urls = []
    list.each{ |item| 
        list_urls << item[1]["given_url"]
    }

    list_urls
end

def add_url_to_google_account(url)

    url = URI("https://getpocket.com/v3/add?url=#{url}&consumer_key=#{GET_POCKET_CONSUMER_KEY_GOOGLE}&access_token=#{GET_POCKET_ACCESS_TOKEN_GOOGLE}")

    puts url

    https = Net::HTTP.new(url.host, url.port);
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["Authorization"] = "Basic Og=="
    request["Cookie"] = "PHPSESSID=cc44699fef0dca60b1236c6799e20f98; sess_guid=14agfd13p82dtD2c93TGy5dRcpA2p37b2ePj26V1e1b241y8a6270w08ReDjBafr; sess_start_time=1593603149; AUTH_BEARER_default=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzUxMiJ9.eyJpYXQiOjE1OTM2Njk1OTUsImp0aSI6Ik01Q2ozVmhIUzE0aGV2ZzBpY1JkdENSeUJvenBcLzFlUzB5aVwvY2dUTmg2UT0iLCJpc3MiOiJnZXRwb2NrZXQuY29tIiwibmJmIjoxNTkzNjY5NTk1LCJleHAiOjE1OTM2NzMxOTUsImRhdGEiOiJfc2YyX2F0dHJpYnV0ZXN8YTowOnt9X3N5bWZvbnlfZmxhc2hlc3xhOjA6e31fc2YyX21ldGF8YTozOntzOjE6XCJ1XCI7aToxNTkzNjY5NTk1O3M6MTpcImNcIjtpOjE1OTM2Njk1OTU7czoxOlwibFwiO3M6MTpcIjBcIjt9In0.sR6igmiLEzbY3ujSIHsLYwdjPJUtUKWmaYZrAGvRW_hnyHkqxuWRquGwj4EpTwBPrT41OEVe6f6oUekhYWMFJRaT1eLZO86kmUDOpiEL8Vwu9_0ceyDW3-HdxUOD5gNtCBZM3JjNCakPyC_4nWUd3846jC32wii_06dRTS4UG7W2giFjrRiZOLCBo0YM97ANIXP2mGbWnlRZ0E75R_N26mHCQCr64iVIyyy1aKcO9X2qhQeS-LxFQtLMDf4YCLoVtbT6mjUg-AGxMU4wRg51en55L8JoCG7Agq5oSN-RXDFcGAhZuVg1_TVmhKQz3M07-pE_5Mkzu83eDfQWg0ezvg"

    response = https.request(request)
    puts response.read_body

end

def add_everything_to_google
    envato_items = get_envato_items
    urls = get_urls(envato_items)
    
    urls.each{ |url|
        add_url_to_google_account(url)
    }
end

add_url_to_google_account("https://support.geckoboard.com/hc/en-us/articles/360006412678-Import-JSON-data-to-a-Google-Sheet")