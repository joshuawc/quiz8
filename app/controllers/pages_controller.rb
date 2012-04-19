class PagesController < ApplicationController
  def login
    if params[:username] == nil
      username = password = ""
    else
      username = params[:username]
      password = params[:password]
    end
    conn = ActiveRecord::Base.connection
    access_level = conn.select_value("select getID('" + username + "','" + password + "')").to_i
    cookies.signed[:al] = access_level
    redirect_to :controller => "pages", :action => "check"
  end
  def check
    @al = cookies.signed[:al]
    respond_to do |format|
      format.html {render :text => @al}
    end
  end
end
