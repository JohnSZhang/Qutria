class Api::TaggablesController < Api::ApplicationController
  before_action :require_login

  def create
    tag = Taggable.CreateAndTag(taggable_params[:name])
    unless tag
      render json: "{ 'error': 'Cannot Find Answer'}",
      status: :unprocessable_entity
    end

    type, id = taggable_params[:taggingstype], taggable_params[:taggingsid]
    @taggable = Taggable.new(
      tag: tag,
      taggings_id: id,
      taggings_type: type
    )
    if @taggable.save
      render template: "api/taggable"
    else
      render json: "{ 'error': '#{@taggable.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end

  def destroy
    params =  taggable_params
    @taggable = Taggable.find_by(taggable_params)

    if @taggable.destroy
      render template: "api/taggable"
    else
      render json: "{ 'error': '#{@taggable.errors.full_messages}'}",
      status: :unprocessable_entity
    end
  end


  private
    def taggable_params
      params.require(:taggable).permit(:name, :tag_id, :taggings_id, :taggings_type)
    end
end
