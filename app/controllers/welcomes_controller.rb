require 'fileutils'

class WelcomesController < ApplicationController
  before_action :set_welcome, only: [:show, :edit, :update, :destroy]
  # GET /welcomes
  # GET /welcomes.json
  def index
    @recommend_apps = Welcome.approved.recommend.order('recommend DESC').limit(8)
    @new_apps = Welcome.approved.newapp.limit(8)
  end

  # GET /welcomes/1
  # GET /welcomes/1.json
  def show
    if @welcome.approved == 1
      @welcome.update_attribute(:view, @welcome.view + 1)
      @welcome.update_attribute(:viewhehe, @welcome.viewhehe + rand(6))
    else
      #pending
      render :pending
    end
  end

  # GET /welcomes/new
  def new
    @welcome = Welcome.new
  end

  # GET /welcomes/1/edit
  def edit
  end

  # POST /welcomes
  # POST /welcomes.json
  def create
    #@welcome = Welcome.new(welcome_params)
    logo = welcome_params[:logo]
    if logo
      ext = File.extname(logo.original_filename)
      @logoname = Digest::MD5.hexdigest(Time.now.to_s + rand(10000).to_s) + ext
      File.open("#{Rails.root}/public/up/#{@logoname}", "wb") do |f|
        f.write(logo.read)
      end
      plogo = @logoname
    end
    pimgs = []
    imgs = welcome_params[:imgs]
    if imgs
      imgs.each do |img|
        ext = File.extname(img.original_filename)
        @logoname = Digest::MD5.hexdigest(Time.now.to_s + rand(10000).to_s) + ext
        File.open("#{Rails.root}/public/up/#{@logoname}", "wb") do |f|
          f.write(img.read)
        end
        pimgs << @logoname.to_s.strip
      end
    end
    @welcome = Welcome.new
    @welcome.name = welcome_params[:name]
    @welcome.logo = plogo
    @welcome.decription = welcome_params[:decription]
    @welcome.link = welcome_params[:link]
    @welcome.org = welcome_params[:org]
    @welcome.imgs = pimgs

    respond_to do |format|
      if @welcome.save
        format.html { redirect_to @welcome, notice: 'Welcome was successfully created.' }
        format.json { render :show, status: :created, location: @welcome }
      else
        format.html { render :new }
        format.json { render json: @welcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /welcomes/1
  # PATCH/PUT /welcomes/1.json
  def update
    #@welcome = Welcome.new(welcome_params)
    logo = welcome_params[:logo]
    if logo
      ext = File.extname(logo.original_filename)
      @logoname = Digest::MD5.hexdigest(Time.now.to_s + rand(10000).to_s) + ext
      File.open("#{Rails.root}/public/up/#{@logoname}", "wb") do |f|
        f.write(logo.read)
      end
      if @welcome.logo && File.exist?("#{Rails.root}/public/up/#{@welcome.logo}")
        File.delete("#{Rails.root}/public/up/#{@welcome.logo}")
      end
      plogo = @logoname
    end
    pimgs = []
    imgs = welcome_params[:imgs]
    if imgs
      imgs.each do |img|
        ext = File.extname(img.original_filename)
        @logoname = Digest::MD5.hexdigest(Time.now.to_s + rand(10000).to_s) + ext
        File.open("#{Rails.root}/public/up/#{@logoname}", "wb") do |f|
          f.write(img.read)
        end
        pimgs << @logoname.to_s.strip
      end
      if @welcome.imgs
        @welcome.imgs.each do |img|
          File.delete("#{Rails.root}/public/up/#{img}") if File.exist?("#{Rails.root}/public/up/#{img}")
        end
      end
    end
    @welcome.name = welcome_params[:name] unless welcome_params[:name].blank?
    @welcome.logo = plogo unless plogo.blank?
    @welcome.decription = welcome_params[:decription] unless welcome_params[:decription].blank?
    @welcome.link = welcome_params[:link] unless welcome_params[:link].blank?
    @welcome.org = welcome_params[:org] unless welcome_params[:org].blank?
    @welcome.imgs = pimgs unless pimgs.blank?
    @welcome.recommend = welcome_params["recommend"] unless welcome_params["recommend"].blank?
    @welcome.approved = welcome_params["approved"] unless welcome_params["approved"].blank?

    respond_to do |format|
      if @welcome.save
        format.html { redirect_to @welcome, notice: 'Welcome was successfully updated.' }
        format.json { render :show, status: :ok, location: nil }
      else
        format.html { render :edit }
        format.json { render json: @welcome.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /welcomes/1
  # DELETE /welcomes/1.json
  def destroy
    @welcome.destroy
    respond_to do |format|
      format.html { redirect_to welcomes_url, notice: 'Welcome was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def admin
    @app = Welcome.order('id desc').all
  end
  def about
  end

  def heart
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_welcome
      @welcome = Welcome.find(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def welcome_params
      params.require(:welcome).permit(:name, :logo, :decription, :link, :org, :recommend, :approved, :imgs => [])
    end
end
