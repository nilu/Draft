class Api::V1::PlayersController < Api::V1::ApiController

  before_filter :find_player

  api :GET, "/players/:id", 'Show player'
  description "Show player based on id"
  example '
  RESPONSE
  {
    "message": "Success",
    "success": true,
    "status": 200,
    "player": {
      "id": 1,
      "name_brief": "D. A.",
      "first_name": "David",
      "last_name": "Aardsma",
      "position": "RP",
      "age": 33,
      "average_position_age_diff": "+5"
    }
  }
  '

  param :id, Integer, :required => true
  def show
    api_status(200, true, "Success")
  end

  private

  def find_player
    @player = Player.find_by_id(params[:id])
    if @player.nil?
      api_status(400, false, "Bad Request: Player with id '#{params[:id]}' does not exist.")
      return render '/api/v1/default', :status => :bad_request
    end
  end
end
