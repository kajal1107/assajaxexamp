class UsersController < ApplicationController
	def load_routers  
		@users_default = Gmaps4rails.build_markers(User.all) do |plot, marker|  
	  	marker.lat plot.latitude  
	 		marker.lng plot.longitude  

	  	@status = rand(1..4)  
	  	@battery = rand(10..90)  
	  	@ip = "192.168."+rand(0..255).to_s+"."+rand(15..250).to_s  
	  	@connected = rand(50..100)  

	  	if @status == 1  
	   		url_alert = "/good.png"  
	    	@status == "Normal"  
	  	else  
	    	url_alert = "/alert.png"  
	  	end  

	  	marker.picture({  
	  	"url" => url_alert,  
	  	"width" => 35,  
	  	"height" => 30  
	  	})  

	  	marker.infowindow render_to_string(:partial => "/routers/info",   
	  		:locals => {:name => plot.name, :battery => @battery, :date => rand(6.months.ago..Time.now), :ip => @ip, :connected => @connected })  
		end  
 	end

	def index
		@users =User.all
	end

	def show
		@user = User.find(params[:id])  
	end

	def new
		@user = User.new
	end

	def create
		@users =User.all
		@user = User.new(user_params)
		respond_to do |format|
    	if @user.save
	    	format.js
    	else
    		format.html { render :index }
    	end
    end
	end

	def destroy
		@user = User.find(params[:id])
		@user.destroy
		redirect_to users_path
	end

	private
		def user_params
			params.require(:user).permit(:name,:u_address, :town, :area, :country, :postal_code)
		end
end
