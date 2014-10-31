class Api::VotesController < Api::ApplicationController
  before_action :require_login
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
    @vote = Vote.create!(
    user: user,
    votable_id: params["id"],
    votable_type: params["type"],
    vote_type: value
    )

  end

  def get_vote(params)
    user = current_user
    id, type = params["id"], params["type"]
    @vote = Vote.find_by(
    user: user,
    votable_id: id,
    votable_type: type
    )
  end

end
