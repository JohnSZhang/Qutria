class VotesController < ApplicationController
  before_action :require_login

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

  def upvote
    vote = get_vote(vote_params)
    if vote && vote.vote_type < 1
      vote.vote_type += 1
      if vote.save
        render text: "sucessfully upvoted"
      else
        render text: "cannot update", status: :unprocessable_entity
      end
    else
      create_vote(vote_params, 1)
      render text: "sucessfully upvoted"
    end
  end

  def downvote
    vote = get_vote(vote_params)
    if vote && vote.vote_type > -1
      vote.vote_type -= 1
      if vote.save
        render text: "sucessfully downvoted"
      else
        render text: "cannot update", status: :unprocessable_entity
      end
    else
      create_vote(vote_params, -1)
      render text: "sucessfully downvoted"
    end
  end

  def render_user_vote(vote_params)
    vote = get_vote(vote_params)
    render text: vote ? vote.vote_type : 0
  end

  private
  def vote_params
    params.require(:vote).permit(:id, :type)
  end

  def create_vote(params, value)
    user = current_user
    @vote = Vote.create(
    user: user,
    votable_id: params[:id],
    votable_type: params[:type],
    vote_type: value
    )
  end

  def get_vote(params)
    user = current_user
    id, type = params[:id], params[:type]
    @vote = Vote.find_by(
    user: user,
    votable_id: id,
    votable_type: type
    )
  end

end
