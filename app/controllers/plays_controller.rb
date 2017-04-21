class PlaysController < ApplicationController
    before_action :find_play, only: [:show,:edit,:update,:destroy] 
    
    def index
     @plays = Play.order(created_at: :desc)
    end 

    def show
    end

    def new
        #@play = Play.new
        @play = current_user.plays.build
        #listing all the categories by the names and ids and we need a array of values for dropdown in view
        @categories = Category.all.map{|c| [c.name,c.id]  }
    end

    def create
        #@play = Play.new(play_params)
        @play = current_user.plays.build(play_params)
        @play.category_id = params[:category_id]
        if @play.save
            redirect_to root_path
        else
            render 'new'
        end 
    end

    def edit
      @categories = category.all.map{|c| [c.name,c.id]  }  
    end

    def update
        @play.category_id = params[:category_id]

        if @play.update(play_params)
   # displaying show page         
         redirect_to play_path(@play)
        else
          render 'edit'    
        end  
        
    end

    def destroy
        @play.destroy
        redirect_to root_path
    end

private

    def play_params
     params.require(:play).permit(:title, :description, :director, :category_id)
    end    

    def find_play
     @play = Play.find(params[:id])  
    end    
end
