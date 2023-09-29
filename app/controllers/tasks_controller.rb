class TasksController < ApplicationController
  before_action :set_task, only: [:destroy]

  def index
    tasks_with_future_deadline = Task.where("finish_date >= ?", Date.today).order(finish_date: :asc)
    tasks_with_past_deadline = Task.where("finish_date < ?", Date.today).order(finish_date: :asc)
    #tasks_with_deadline = Task.where.not(finish_date: nil).order(finish_date: :asc)
    tasks_without_deadline = Task.where(finish_date: nil).order(created_at: :asc)
    @tasks = tasks_with_future_deadline + tasks_with_past_deadline + tasks_without_deadline
    @incomplete_tasks = @tasks.reject(&:completed?)
    #@tasks = tasks_with_deadline + tasks_without_deadline
    #@tasks = Task.order(finish_date: :asc)
    #@task_number = 1
  end

  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      redirect_to tasks_url, notice: 'Task successfully created.'
    else
      render :new
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_url, notice: 'Task successfully destroyed.'
  end

begin
  def finish
    @task = Task.find(params[:id])
    @task.update(completed: true)
    redirect_to tasks_url, notice: 'Task successfully finished.'
  end 
end

private

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :finish_date)
  end
end
