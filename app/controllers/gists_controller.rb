class GistsController < ApplicationController
  before_action :find_gist, only: %i(show edit update destroy)

  def index
    @categories = Category.all

    if params[:category]
      @category = Category.find_by(name: params[:category])
      @gists = Gist.where(category_id: @category.id).order('created_at DESC')
    else
      @gists = Gist.all.order('created_at DESC')
    end
  end

  def new
    @gist = Gist.new
  end

  def create
    @gist = Gist.new(gist_params)

    if @gist.save
      flash[:notice] = 'New gist successfully added!'
      redirect_to @gist
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @gist.update(gist_params)
      redirect_to @gist
    else
      render :edit
    end
  end

  def destroy
    @gist.detroy
    redirect_to gists_path
  end

  private

  def find_gist
    @gist = Gist.find(params[:id])
  end

  def gist_params
    params.require(:gist).permit(:filename, :description, :content)
  end
end
