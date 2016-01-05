# -*- encoding : utf-8 -*-
class HomeController < BaseController
  
  def index
    @posters = Poster.available.sorted.all
    @imaged_articles = Article.visible.featured.imaged.latest.all
    @articles = Article.visible.nonimage.latest.limit(19)
    @topics = Topic.visible.sorted.limit(6)
    @theses = Thesis.sorted.limit(6)
    @resource = Resource.visible.latest.first
    @books = Book.sorted.limit(12)
    @publication_volumes = PublicationVolume.sorted_by_time.limit(2)
    @newsletter = Newsletter.sorted.first
    @publication_volume = Publication.owned.first.volumes.sorted_by_time.first
    @organization_members = OrganizationMember.sorted_by_pinyin
    @links = Link.sorted.limit(12)
  end
end
