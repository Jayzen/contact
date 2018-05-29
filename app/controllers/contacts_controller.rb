class ContactsController < ApplicationController
  before_action :find_contact, only: [:show, :edit, :update, :destroy]
  
  def index
    session[:selected_group_id] = params[:group_id]
    if params[:group_id] && !params[:group_id].empty?
      #@contacts = Contact.where(group_id: params[:group_id]).page(params[:page])
      @contacts = Group.find(params[:group_id]).contacts.page(params[:page])
    else
      @contacts = Contact.order("created_at desc").page(params[:page])
    end
  end

  def show
  end

  def new
    @contact = Contact.new
  end

  def create
    @contact = Contact.new(contact_params)
    if @contact.save
      flash[:success] = "新建成功"
      redirect_to contacts_path(previous_query_string)
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @contact.update(contact_params)
      flash[:success] = "更新成功"
      redirect_to contacts_path(previous_query_string)
    else
      render 'edit'
    end
  end

  def destroy
    @contact.destroy
    flash[:success] = "删除成功"
    redirect_to contacts_path(previous_query_string)
  end

  private
    def find_contact
      @contact = Contact.find(params[:id])
    end

    def contact_params
      params.require(:contact).permit(:name, :company, :email, :phone, :address, :group_id)
    end

    def previous_query_string
      session[:selected_group_id] ? { group_id: session[:selected_group_id] } : {}
    end
end
