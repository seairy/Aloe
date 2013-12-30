# -*- encoding : utf-8 -*-
class PublicationVolumesController < BaseController
  before_filter :set_location
  
  def index
    if params[:publication_id].blank?
      @publication_volumes = PublicationVolume.sorted_by_time.paginate page: params[:page], per_page: 10
      extend_location_chain '期刊列表'
    else
      @publication = Publication.find params[:publication_id]
      @publication_volumes = @publication.volumes.sorted_by_time.paginate page: params[:page], per_page: 10
      extend_location_chain @publication.name
    end
    
  end
  
  def show
    @publication_volume = PublicationVolume.find params[:id]
    extend_location_chain "《#{@publication_volume.publication.name}》", publication_publication_volumes_path(@publication_volume.publication)
    extend_location_chain "第#{@publication_volume.name}期"
  end
  
  protected
  def set_location
    extend_location_chain '期刊杂志', publication_volumes_path
  end
end
