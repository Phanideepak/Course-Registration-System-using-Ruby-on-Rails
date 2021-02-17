class CoursesController < ApplicationController
  before_action :logged_in?
  before_action :require_admin, only: [:new, :edit, :create, :update, :destroy, :list]

  def index
    @courses = Course.all
  end

  def show
    id = params[:id]
    @course = Course.find(id)
    @students = Registration.find_by_sql("SELECT * FROM Registrations WHERE c_id=#{id}")
  end

  def new
    @course = Course.new
  end

  def edit
    @course = Course.find(params[:id])
  end

  def list
    @courses = Course.find_by_sql(
        "SELECT * FROM COURSES WHERE admin = #{current_user.id}"
      )
  end

  def create
    @course = Course.new(course_params)
    @course.admin = current_user.id
    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @course = Course.find(params[:id])
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @course = Course.find(params[:id])
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :credits)
    end
 
  def require_admin
    unless admin?
      flash[:error] = "You must be admin to create a new course"
      redirect_to "/courses"
    end
  end

  def logged_in?
    if current_user.nil?
        redirect_to "/login"
      else
        current_user
      end
  end

end
