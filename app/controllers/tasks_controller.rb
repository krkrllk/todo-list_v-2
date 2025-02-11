class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.includes(:sub_tasks).all
  end

  def show; end

  def new
    @task = Task.new
    @task.sub_tasks.build # Build an empty subtask for the form
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: 'Task and subtasks successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @task.sub_tasks.build if @task.sub_tasks.empty? # Build empty subtask fields if none exist
  end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: 'Task and subtasks successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: 'Task successfully deleted.'
  end

  private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :completed, sub_tasks_attributes: [:id, :title, :completed, :_destroy])
  end
end
