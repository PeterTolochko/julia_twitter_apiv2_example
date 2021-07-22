using HTTP
using JSON

# set environment variable:
# ENV["BEARER_TOKEN"] = "YOUR_BEARER_TOKEN"

# get bearer token from enviroment 
bearer_token = ENV["BEARER_TOKEN"]

search_url = "https://api.twitter.com/2/tweets/search/all"

query_params = Dict("query" => "(from:julialanguage -is:retweet) OR #julialang",
                "tweet.fields" => "author_id")


headers = [
    "Authorization" => "Bearer $(bearer_token)",
    "User-Agent" => "v2FullArchiveSearchJulia"
]


function connect_to_endpoint(url, headers, query)
    response = HTTP.request("GET", url, headers = headers, query = query_params)
    println(response.status)
    if response.status != 200
        throw(ErrorException)
    end
    return JSON.parse(String(response.body))
end


json_response = connect_to_endpoint(search_url, headers, query_params)


JSON.print(json_response)