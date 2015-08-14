class Api::V1::ApiController < ApplicationController
  protect_from_forgery with: :null_session
  layout 'api/v1/application'
end