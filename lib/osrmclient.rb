require "osrmclient/version"
require 'typhoeus'
require 'typhoeus/adapters/faraday'

class Osrmclient

  def initialize(options = {})
      server = options[:server] || "localhost"
      port = options[:port] || 80

      Faraday::Utils.default_params_encoder = Faraday::FlatParamsEncoder
      @connection = Faraday.new(url: "#{server}:#{port}") do |f|
          f.adapter :typhoeus
      end
  end

  def locate(options = {})
    lat = options[:lat] || 0
    lon = options[:lon] || 0
    @connection.get("/locate", {loc: "#{lat},#{lon}"})
  end


  def nearest(options = {})
    lat = options[:lat] || 0
    lon = options[:lon] || 0
    @connection.get("/nearest", {loc: "#{lat},#{lon}"})
  end


  def viaroute(options = {})
    ops = options.dup

    lat1 = ops.delete(:lat1) || 0
    lon1 = ops.delete(:lon1) || 0
    lat2 = ops.delete(:lat2) || 0
    lon2 = ops.delete(:lon2) || 0

    url = "/viaroute?"
    url << "loc=#{lat1},#{lon1}&loc=#{lat2},#{lon2}"
    unless ops.nil?
      ops.each_pair do |key, value|
        url << "&#{key}=#{value}"
      end
    end
    @connection.get(url)
  end


  def table(options = {})
    url = "/table?"

    ops = options.dup
    locations = ops.delete(:locations)

    unless locations.nil?
      locations.each_slice(2) do |lat, lon|
        url << "&loc=#{lat[1]},#{lon[1]}"
      end
    end

    unless options.nil?
      ops.each_pair do |key, value|
        url << "&#{key}=#{value}"
      end
    end
    @connection.get(url)
  end

end
