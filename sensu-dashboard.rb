#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), 'lib'))

require 'sinatra/base'
require 'haml'
require 'json'
require 'rufus/scheduler'
require 'pry'
require 'deep_merge'
require 'rest-client'
require 'models'
require 'hash-extensions'

# SensuDashboard
class SensuDashboard < Sinatra::Base

  before '/*' do
    @servers = Server.all
    @services = Service.all
    @views = View.all
  end

  get '/api/servers/?' do
    @servers.to_json
  end

  get '/api/services/?' do
    output = []
    @services.each do |service|
      url = "http://#{service.server.name}:4567/events"
      begin
        events = RestClient.get(url)
      rescue => e
        events = '{}'
      end
      data = service.attributes
      data[:allevents] = JSON.parse(events)
      output << data
    end
    output.to_json
  end


  get '/api/views/?' do
    @views.to_json
  end

  get '/*' do
    erb :index
  end


end # Class SensuDashboard
