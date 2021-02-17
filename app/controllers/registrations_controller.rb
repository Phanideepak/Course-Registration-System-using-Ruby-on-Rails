class RegistrationsController < ApplicationController
  before_action :logged_in?
  before_action :require_admin, only: [:edit,:update]

  def index
    @registrations = Registration.all
  end

  def show
    @registration = Registration.find(params[:id])
  end

  def new
    @registration = Registration.new
  end

  def edit
    @registration = Registration.find(params[:id])
  end

  def list
    @registrations = Registration.find_by_sql("SELECT * FROM REGISTRATIONS WHERE s_id = #{current_user.id}")
    @sum_of_credits = 0
    @total_sum = 0
    @registrations.each do |registration|
      unless registration.grade.nil?
        @sum_of_credits += Course.find(registration.c_id).credits
        @total_sum += (registration.grade)*(Course.find(registration.c_id).credits)
      end
    end
    @gpa = @total_sum.to_f/(@sum_of_credits.to_f)
  end

  def create
    @registration = Registration.new(create_params)
    @registration.s_id = current_user.id
    @registration.grade = nil
    respond_to do |format|
      if @registration.save
        format.html { redirect_to registrations_url, notice: 'Registration was successfully created.' }
        format.json { render :show, status: :created, location: @registration }
      else
        format.html { render :new }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @registration = Registration.find(params[:id])
    respond_to do |format|
      if @registration.update(registration_params)
        format.html { redirect_to @registration, notice: 'Registration was successfully updated.' }
        format.json { render :show, status: :ok, location: @registration }
      else
        format.html { render :edit }
        format.json { render json: @registration.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @registration = Registration.find(params[:id])
    @registration.destroy
    respond_to do |format|
      format.html { redirect_to "/", notice: 'Course successfully dropped.' }
      format.json { head :no_content }
    end
  end

  private

    def set_registration
      @registration = Registration.find(params[:id])
    end

    def registration_params
      params.require(:registration).permit(:c_id, :grade)
    end

    def create_params
      params.permit(:c_id,:grade)
    end

    def logged_in?
      if current_user.nil?
        redirect_to "/login"
      else
        current_user
      end
    end

    def require_admin
      unless admin?
        flash[:error] = "You must be admin to create a new course"
        redirect_to "/courses"
      end
    end
end
