class QuestionnairesController < ApplicationController
  before_action :set_questionnaire, only: [:show, :edit, :update, :destroy]

  

  
  # GET /questionnaires
  # GET /questionnaires.json
  def index

    @questionnaires = Questionnaire.all
  end

  # GET /questionnaires/1
  # GET /questionnaires/1.json
  def show
    @questionnaire = Questionnaire.find(params[:id])
  end

  # GET /questionnaires/new
  def new
    @questionnaire = Questionnaire.new

    Beer.all.each do |beer|
      @questionnaire.ratings.build(beer: beer)
    end
  end

  # GET /questionnaires/1/edit
  def edit
  end
  
  def project_info
  end

  # POST /questionnaires
  # POST /questionnaires.json
  def create
    @questionnaire = Questionnaire.new(questionnaire_params)

    respond_to do |format|
      if @questionnaire.save
        format.html { redirect_to @questionnaire, notice: 'Brawo, dotarłeś do końca ankiety. Wielkie dzięki za poświęcony czas.' }
        format.json { render action: 'show', status: :created, location: @questionnaire }
      else
        format.html { render action: 'new' }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questionnaires/1
  # PATCH/PUT /questionnaires/1.json
  def update
    respond_to do |format|
      if @questionnaire.update(questionnaire_params)
        format.html { redirect_to @questionnaire, notice: 'Zaktualizowałes swoją ankietę. Dzięki wielkie za rzetelność' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @questionnaire.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questionnaires/1
  # DELETE /questionnaires/1.json
  def destroy
    @questionnaire.destroy
    respond_to do |format|
      format.html { redirect_to questionnaires_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questionnaire
      @questionnaire = Questionnaire.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questionnaire_params
      params.require(:questionnaire).permit(
        :age,
        :sex_id,
        :city,
        :education_id,
        :ratings_attributes => [
          :id,
          :beer_id,
          :taste,
          :color,
          :price,
          :design
        ]
      )
    end
end
