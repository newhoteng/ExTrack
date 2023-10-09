class GroupsController < ApplicationController
  before_action :set_group, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /groups or /groups.json
  def index
    @groups = Group.includes(:expenses).where(user_id: current_user.id)
  end

  # GET /groups/new
  def new
    @group = Group.new
  end

  # POST /groups or /groups.json
  def create
    @group = current_user.groups.new(group_params)
    @group.name = @group.name.capitalize

    if @group.save
      redirect_to groups_url
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group
    @group = Group.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def group_params
    params.require(:group).permit(:name, :icon)
  end
end
