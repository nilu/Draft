require 'spec_helper'

describe Api::V1::PlayersController, :type => :request do
  let(:url) { '/api/v1/players/' }

  before :each do
    @player = FactoryGirl.create(:player)
  end
  
  context '#show' do
    it 'status should return 400 if given an invalid id' do
      invalid_id = '9999'
      get url + invalid_id, format: :json
      response.status.should == 400
    end

    it 'status should return 200 if a valid id is given' do
      valid_id = @player.id.to_s
      get url + valid_id, format: :json
      response.status.should == 200
    end
  end
end
