class VotesController < ApplicationController

  def create
    user = current_user
    @vote = Vote.new(
      user: user,
      votable_id: params[:vote][:id],
      votable_type: params[:vote][:type]
    )
    if @vote.save
      redirect_to root_url
    else
      flash[:msg] = @vote.errors.full_messages
      redirect_to root_url
    end
  end


  def destroy
    @vote = Vote.find_by(
      votable_id: params[:vote][:id],
      votable_type: params[:vote][:type],
      user: current_user
    )

    if @vote && @vote.destroy
      redirect_to root_url
    else
      flash[:msg] = @vote.errors.full_messages
      redirect_to root_url
    end
  end

end
