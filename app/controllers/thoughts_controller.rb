class ThoughtsController < ApplicationController

  def index
    @thought = Thought.new
    @thoughts = Thought.all.sort {|a,b|b.updated_at <=> a.updated_at}
  end

  def show
    @thought = Thought.find(params[:id])
  end

  def new
    @thought = Thought.new
  end

  def edit
    @thought = Thought.find(params[:id])
  end

  def create
    @thought = Thought.new(thought_params)

    p thought_params

    if @thought.save
      redirect_to thoughts_path
    else
      render 'new'
    end
  end

  def update
    @thought = Thought.find(params[:id])

    if @thought.update(thought_params)
      redirect_to thoughts_path
    else
      render 'edit'
    end
  end

  def destroy
    @thought = Thought.find(params[:id])
    @thought.destroy

    redirect_to thoughts_path
  end

  private
    def thought_params
      params.require(:thought).permit(:text)
    end
end
