class GroupsController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def ensure_correct_user
    @group = Group.find(params[:id])
    unless @group.owner_id == current_user.id
      redirect_to groups_path
    end
  end


  def index
    @groups = Group.all
    @book = Book.new
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
    @group.save
    redirect_to groups_path
  end

  def show
    @group = Group.find(params[:id])
    @book = Book.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])
    @group.update(group_params)
    redirect_to groups_path
  end

  def new_mail
    @group = Group.find(params[:group_id])
  end
  
  def send_mail
    @group = Group.find(params[:group_id])
    group_users = @group.users
    @title = params[:title]
    @content = params[:content]
    EventMailer.send_mail(group_users, @title, @content).deliver

  end

  private

  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end
end
