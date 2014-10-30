class GamesController < ActionController::Base
	def new
    @game = Game.new
  end

	def show
		@game = Game.find(params[:id])
	end

	def create
		@event = Event.find(params[:event_id])
		@game  = Game.create(status:"pending")
		@game.users << User.find(session[:user_id])
		@event.games << @game
		@event.two_games?
		redirect_to event_path(@event)
	end

	def update
		p "*" * 20
		p params
		p "*" * 20
		@game = Game.find(params[:game_id])


		if params[:won] == "true"
			@winner = User.find(session[:user_id])
		else
			@winner = @game.users.where.not(id: session[:user_id]).first
		end
		@game.declare_winner(@winner)

		redirect_to event_path(@game.event)

	end

	def destroy
		@game = Game.find(params[:id])
		@event = @game.event
    @game.destroy

    redirect_to event_path(@event)
  end
end
