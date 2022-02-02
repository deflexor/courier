require 'net/http'

class CourierTasksController < ApplicationController

  before_filter :fetch_task, :only => [:show, :edit, :update, :destroy, :accept, :done, :finish]
  before_filter :require_user
  before_filter :require_admin_user, :only => [:edit, :update, :finish]
  before_filter :require_manager_user, :only => [:delete]


  def post_to_dogs(bills,st)
    url = URI.parse('http://smart.wm.ru/dogs/bill/update_courier' + "?bills=" + bills + "&st=" + st.to_s)
    res, data = Net::HTTP.get(url)
    #logger.debug "resp %s" % res
  end

  def accept
    @courier_task.status = 'accepted'
    @courier_task.touch(:accepted_at)
    @courier_task.courier = current_user
    @courier_task.save
    post_to_dogs(@courier_task.bills, 1)
    redirect_to courier_tasks_url
  end

  def done
    @courier_task.status = 'complete'
    @courier_task.touch(:completed_at)
    @courier_task.save
    post_to_dogs(@courier_task.bills, 2)
    redirect_to courier_tasks_url
  end

  def finish
    @courier_task.status = 'finished'
    @courier_task.touch(:finished_at)
    @courier_task.save
    post_to_dogs(@courier_task.bills, 3)
    redirect_to courier_tasks_url
  end

  # GET /courier_tasks
  # GET /courier_tasks.xml
  def index
    conds = {}
    if(current_user.is_admin? || current_user.is_courier?)
      # no conds = admin and courier can see all tasks
    elsif(current_user.is_manager?)
      conds[:manager_id] = current_user.id
      # else # courier also see all tasks
    end

    conds[:status] = if(params[:show_finished] == '1')
      ['finished']
    else
      ['created','complete','accepted']
    end

    @courier_tasks = CourierTask.paginate :page => params[:page] || 1,
      :conditions => conds, :order => "created_at ASC"
    @courier_tasks_count = CourierTask.count :conditions => conds
  end

  # GET /courier_tasks/1
  # GET /courier_tasks/1.xml
  def show
    #@courier_task = CourierTask.find(params[:id])
    @comment = Comment.new
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @courier_task }
    end
  end

  # GET /courier_tasks/new
  # GET /courier_tasks/new.xml
  def new
    if(params[:by])
      @courier_task = CourierTask.find(params[:by]).clone()
    else
      @courier_task = CourierTask.new
    end
  end

  # GET /courier_tasks/1/edit
  def edit
  end

  # POST /courier_tasks
  # POST /courier_tasks.xml
  def create
    @courier_task = CourierTask.new(params[:courier_task])
    @courier_task.status = 'created'
    @courier_task.manager = current_user
    respond_to do |format|
      if @courier_task.save
        flash[:notice] = 'Успешно добавлено новое задание.'
        format.html { redirect_to @courier_task }
        format.xml  { render :xml => @courier_task, :status => :created, :location => @courier_task }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @courier_task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /courier_tasks/1
  # PUT /courier_tasks/1.xml
  def update
    if @courier_task.update_attributes(params[:courier_task])
      flash[:notice] = 'Задание обновлено.'
      redirect_to @courier_task
    else
      render :action => "edit"
    end
  end

  # DELETE /courier_tasks/1
  # DELETE /courier_tasks/1.xml
  def destroy
    @courier_task.destroy
    redirect_to(courier_tasks_url)
  end

  private
  def fetch_task
    @courier_task = CourierTask.find(params[:id])
  end
end
