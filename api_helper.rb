class ApiHelper
  require 'rest-client'
  attr_reader :token, :return_code, :num_elements, :end_point
  attr_accessor :limit, :func, :sort, :query, :asset_id, :asset_id_retrieved


  def initialize
    # response = RestClient::Request.execute method: :post,
    #                                         #                                         url: 'http://interview-testing-api.webdamdb.com/oauth/token',
    #                                         #                                         user: '4', password: '4ovGa5yXfHnWR47wGRVUfKlDTBxC3WQtnkmO5sgs',
    #
    #                                         #                                         grant_type: 'client_credentials'
    @token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6ImZiZWYzOTkwNzg4YzY3NzI2MjVkNGM4ZWE1MWE5YTAwZTNhYmViNjdmNzJhMDVjOWRlNTVjMWQxNDQ2YWM0NjkwYTg2MzE4NDg3OWEwZWUyIn0.eyJhdWQiOiI0IiwianRpIjoiZmJlZjM5OTA3ODhjNjc3MjYyNWQ0YzhlYTUxYTlhMDBlM2FiZWI2N2Y3MmEwNWM5ZGU1NWMxZDE0NDZhYzQ2OTBhODYzMTg0ODc5YTBlZTIiLCJpYXQiOjE0OTYxOTUzNjcsIm5iZiI6MTQ5NjE5NTM2NywiZXhwIjoxNDk2MTk4OTY3LCJzdWIiOiIiLCJzY29wZXMiOltdfQ.TFOgZKIwLU2oTd09E9EI0ei7dXstwaMNfTxTCuhjahPEGfPc_t3Nh6iJI6EgdH54na97158Se1zGcDJvXK9cyEMSpZxDKM32O_7IEWIskzeBwJY_kJVQGBn7576TPHe4wjurFhL-mf_q-vZgTcfpwW9ML1e97cfstfqGWq8iM_cENb7W8RCaPkh8ipMeWw0NFYYrDEfTxLdzf-g33FJu3YVp1CSL1OSTtV8wIsCV3FZ_20soswbBuEG_kc96eFbMHNBQLrlXTShiGE2myArZa_Ze0a7wbFohGpK7H5Qr9LKH2fl58V3UjKF3fhh_ChnM16L-6tVlYeq0pBU_jlOKdG59aPwI8iSTOae8rScE_F4GY7Z10nhIofivFWu7QkzRSGJUa1a0yC3ZKFtiVACpb6ofKXxKgYK2yQMDd9bK1etAg049yD6T4OPkeWhIQFeoacO8K1fQiyUuUL80sW8cbyvLBzfPf3CHdcI46vI5HR84-Y3GmKylxZGhK7rW5k7LoDO6wMW9LqesJeryD9TWT7_BPbKEQqDugLpQrqJ-v-hKHxOXE5wXfL6Ti2_2nO_ZZJgm0Z6XKQlm2_hBSvTThsgRahrf4FSbEQU5ZDKGpfWbzM71Zm9PXH1qXVnQpMUmyO3nLtTUmToyIGWYLQBVsRfmtxVUMTi9cTKQ24XzBCw'
    @query = nil
    @sort = nil
    @limit = nil
    @return_code = nil
    @num_elements = nil
    @end_point = 'http://interview-testing-api.webdamdb.com/api/v1/'
    @func = nil
    @asset_id = nil
    @asset_id_retrieved = nil
    # rc = RestClient.new
    # rc::request
    # client = OAuth2::Client.new(4, "4ovGa5yXfHnWR47wGRVUfKlDTBxC3WQtnkmO5sgs", :site => ' http://interview-testing-api.webdamdb.com/oauth/token')
  end

  def run_search
    # response = nil
    search_url = @end_point+'search'
    params = '?'
    if @query != ""
      params = params+'query='+@query
    end
    if @limit != nil
      if params == '?'
       params = params+'limit='+@limit
      else # multiple optional parameters
        params = params+'&limit='+@limit
      end
    end
    if @sort != nil
      if params == '?'
        params = params+'sort='+@sort
      else
        params = params+'&sort='+@sort
      end
    end
    if params != '?'
      search_url = search_url+params
    end
    puts "The API is search, function is: #{@func}, the query is #{query}, the sort option is #{@sort}, the limit is #{@limit}"
    # puts "The function is: #{@func}, the query is #{query}, the sort option is #{@sort}, the limit is #{@limit}, the return code: #{@ah.return_code} and number of elements is: #{@ah.num_elements}"
    if @func == "get"
      response = RestClient.get search_url,
                               {:Authorization => 'Bearer '+ @token}
      @num_elements = JSON.parse(response).size
    elsif @func == "head"
      response = RestClient.head search_url,
                                {:Authorization => 'Bearer '+ @token}
      @num_elements = response.size
    end
    @return_code = response.code
    puts "The return code: #{@return_code} and number of elements is: #{@num_elements}"
    # @num_elements = JSON.parse(response).size
  end

  def run_asset
    asset_url = @end_point+'asset'
    if @asset_id != nil
      asset_url = asset_url+'/'+@asset_id
    end
    puts "The API is asset, function is: #{@func}"
    if @func == "get"
      response = RestClient.get asset_url,
                                {:Authorization => 'Bearer '+ @token}
      @num_elements = JSON.parse(response).size
      if (@asset_id != "" and @num_elements > 0)
        @asset_id_retrieved = JSON.parse(response)[0]['asset_id']
      end
    elsif @func == "head"
      response = RestClient.head asset_url,
                                 {:Authorization => 'Bearer '+ @token}
      @num_elements = response.size
    end
    @return_code = response.code
    puts "The return code: #{@return_code} and number of elements is: #{@num_elements}"

  end
end
# response = RestClient.get 'http://example.com'
#
