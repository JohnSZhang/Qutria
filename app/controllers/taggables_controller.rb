class TaggablesController < ApplicationController
  before_action :require_login

  def create
    tag = Taggable.CreateAndTag(taggable_params[:name])
    unless tag
      flash[:msg] = 'Cannot Find Or Create Tag'
      redirect_to request.referer
    end

    type, id = params[:taggable][:taggingstype], params[:taggable][:taggingsid]
    @taggable = Taggable.new(
      tag: tag,
      taggings_id: id,
      taggings_type: type
    )
    if @taggable.save
      redirect_to request.referer
    else
      flash[:msg] = @taggable.errors.full_messages
      redirect_to request.referer
    end
  end

  def destroy
    @taggable = Taggable.find(params[:id])
    if @taggable.destroy
      redirect_to request.referer
    else
      flash[:msg] = @taggable.errors_full_messages
      redirect_to request.referer
    end
  end


  private
    def taggable_params
      params.require(:taggable).permit(:name, :taggings_id, :taggings_type)
    end
end
