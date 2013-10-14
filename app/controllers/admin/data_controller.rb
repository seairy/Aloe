# -*- encoding : utf-8 -*-
require 'mysql'

class Admin::DataController < Admin::BaseController
  
  def index
    @statistics = { article: Article.all.count,
      resource: Resource.all.count,
      topic: Topic.all.count,
      thesis: Thesis.all.count,
      book: Book.all.count,
      book_shelf: BookShelf.all.count,
      link: Link.all.count,
      newsletter: Newsletter.all.count,
      seminar: Seminar.all.count,
      seminar_thesis_category: SeminarThesisCategory.all.count,
      seminar_thesis: SeminarThesis.all.count,
      seminar_article: SeminarArticle.all.count,
      seminar_photograph: SeminarPhotograph.all.count,
      seminar_video: SeminarVideo.all.count }
  end
  
  def migrate
    @connection = Mysql.init
    @connection.options(Mysql::SET_CHARSET_NAME, 'utf8')
    @connection.real_connect("localhost", "root", "", "isclt")
    migrated_count = case params[:table_name]
    when 'article' then migrate_articles
    when 'resource' then migrate_resources
    when 'topic' then migrate_topics
    when 'thesis' then migrate_theses
    when 'book' then migrate_books
    when 'book_shelf' then migrate_book_shelves
    when 'link' then migrate_links
    when 'newsletter' then migrate_newsletters
    when 'seminar' then migrate_seminars
    when 'seminar_thesis_category' then migrate_seminar_thesis_categories
    when 'seminar_thesis' then migrate_seminar_theses
    when 'seminar_article' then migrate_seminar_articles
    when 'seminar_photograph' then migrate_seminar_photographs
    when 'seminar_video' then migrate_seminar_videos
    end
    @connection.close
    flash[:notice] = "数据迁移成功！共迁移#{migrated_count}条！"
    redirect_to admin_data_path
  end
  
  protected
  def migrate_articles
    Article.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM articles")
    results.each_hash do |result|
      migrated_count += 1
      category_id = (result['category_id'].to_i > 100005) ? (result['category_id'].to_i - 100001) : (result['category_id'].to_i - 100000)
      Article.create({ id: result['id'], category_id: category_id, title: result['title'].force_encoding('utf-8'), source: result['source'].force_encoding('utf-8'), content: result['content'].force_encoding('utf-8'), visible: result['visible'], featured: result['featured'], views_count: result['views_count'], displayed_at: result['displayed_at'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_resources
    Resource.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM resources")
    results.each_hash do |result|
      migrated_count += 1
      category_id = result['category_id'].to_i - 100000
      image = migrate_asset result['image_id']
      media = migrate_asset result['media_id']
      resource = Resource.create({ id: result['id'], category_id: category_id, title: result['name'].force_encoding('utf-8'), author: result['author'].force_encoding('utf-8'), organization: result['organization'].force_encoding('utf-8'), description: result['description'].force_encoding('utf-8'), media_type: result['media_type'], visible: result['visible'], featured: result['featured'], views_count: result['views_count'], displayed_at: result['displayed_at'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      resource.update_column :image, image
      resource.update_column :media, media
    end
    migrated_count
  end
  
  def migrate_topics
    Topic.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM subjects")
    results.each_hash do |result|
      migrated_count += 1
      forum_id = result['forum_id'].to_i - 100000
      original = result['content_type'] == 1 ? true : false
      Topic.create({ id: result['id'], forum_id: forum_id, original: original, title: result['title'].force_encoding('utf-8'), author: result['author'].force_encoding('utf-8'), content: result['content'].force_encoding('utf-8'), visible: result['approved'], featured: result['featured'], views_count: result['views_count'], displayed_at: result['displayed_at'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_theses
    Thesis.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM theses")
    results.each_hash do |result|
      migrated_count += 1
      image = migrate_asset result['cover_id']
      thesis = Thesis.create({ id: result['id'], title: result['title'].force_encoding('utf-8'), author: result['author'].force_encoding('utf-8'), abstract: result['digest'].force_encoding('utf-8'), keywords: result['keywords'].force_encoding('utf-8'), published_in: result['publication'].force_encoding('utf-8'), volume: result['issue'].force_encoding('utf-8'), published_at: result['published_at'], link: result['link'].force_encoding('utf-8'), featured: result['featured'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      thesis.update_column :image, image
    end
    migrated_count
  end
  
  def migrate_books
    Book.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM books")
    results.each_hash do |result|
      migrated_count += 1
      image = migrate_asset result['image_id']
      book = Book.create({ id: result['id'], name: result['name'].force_encoding('utf-8'), author: result['author'].force_encoding('utf-8'), publisher: result['publisher'].force_encoding('utf-8'), isbn: result['isbn'].force_encoding('utf-8'), published_at: result['published_at'], currency: result['currency'].force_encoding('utf-8'), price: result['price'], description: result['description'].force_encoding('utf-8'), available: result['deprecated'], purchasable: result['available'], featured: result['featured'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      book.update_column :image, image
    end
    migrated_count
  end
  
  def migrate_book_shelves
    BookShelf.delete_all
    migrated_count = 0
    mapping = {}
    results = @connection.query("SELECT * FROM book_content_typeships")
    results.each_hash do |result|
      migrated_count += 1
      if mapping[result['book_content_type_id']].blank?
        type_results = @connection.query("SELECT * FROM book_content_types")
        type_results.each_hash do |type_result|
          p "name = #{type_result['name'].force_encoding('utf-8')}, count = #{BookCategory.where(name: type_result['name'].force_encoding('utf-8')).size}"
          mapping[result['book_content_type_id']] = BookCategory.where(name: type_result['name'].force_encoding('utf-8')).first.id
        end
      end
      BookShelf.create(book_category_id: mapping[result['book_content_type_id']], book_id: result['book_id'])
    end
    migrated_count
  end
  
  def migrate_links
    Link.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM links")
    results.each_hash do |result|
      migrated_count += 1
      Link.create({ id: result['id'], name: result['name'].force_encoding('utf-8'), url: result['url'].force_encoding('utf-8'), visits_count: result['accessed_count'], featured: result['featured'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_newsletters
    Newsletter.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM newsletters")
    results.each_hash do |result|
      migrated_count += 1
      image = migrate_asset result['image_id']
      newsletter = Newsletter.create({ id: result['id'], name: result['name'].force_encoding('utf-8'), description: result['description'].force_encoding('utf-8'), asset_url: result['file_uri'].force_encoding('utf-8'), position: result['position'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      newsletter.update_column :image, image
    end
    migrated_count
  end
  
  def migrate_seminars
    Seminar.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM seminars")
    results.each_hash do |result|
      migrated_count += 1
      Seminar.create({ id: result['id'], name: result['name'].force_encoding('utf-8'), brief_introduction: result['elite_introduction'].force_encoding('utf-8'), introduction: result['introduction'].force_encoding('utf-8'), position: result['position'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_seminar_thesis_categories
    SeminarThesisCategory.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM seminar_catalogs")
    results.each_hash do |result|
      migrated_count += 1
      SeminarThesisCategory.create({ id: result['id'], seminar_id: result['seminar_id'], name: result['name'].force_encoding('utf-8'), position: result['position'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_seminar_theses
    SeminarThesis.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM seminar_achievements")
    results.each_hash do |result|
      migrated_count += 1
      position = result['position'] || 1
      document = migrate_asset result['document_id']
      seminar_thesis = SeminarThesis.create({ id: result['id'], category_id: result['catalog_id'], title: result['title'].force_encoding('utf-8'), author: result['author'].force_encoding('utf-8'), position: position, created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      seminar_thesis.update_column :document, document
    end
    migrated_count
  end
  
  def migrate_seminar_articles
    SeminarArticle.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM seminar_reports")
    results.each_hash do |result|
      migrated_count += 1
      featured = result['featured'] || false
      SeminarArticle.create({ id: result['id'], seminar_id: result['seminar_id'], title: result['title'].force_encoding('utf-8'), source: result['source'].force_encoding('utf-8'), content: result['content'].force_encoding('utf-8'), visible: result['visible'], featured: featured, views_count: result['views_count'], displayed_at: result['displayed_at'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_seminar_photographs
    SeminarPhotograph.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM seminar_photographs")
    results.each_hash do |result|
      migrated_count += 1
      image = migrate_asset result['image_id']
      seminar_photograph = SeminarPhotograph.create({ id: result['id'], seminar_id: result['seminar_id'], title: result['name'].force_encoding('utf-8'), visible: result['visible'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      seminar_photograph.update_column :image, image
    end
    migrated_count
  end
  
  def migrate_seminar_videos
    SeminarVideo.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM seminar_videos")
    results.each_hash do |result|
      migrated_count += 1
      image = migrate_asset result['image_id']
      media = migrate_asset result['media_id']
      seminar_video = SeminarVideo.create({ id: result['id'], seminar_id: result['seminar_id'], title: result['name'].force_encoding('utf-8'), description: result['description'].force_encoding('utf-8'), visible: result['visible'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
      seminar_video.update_column :image, image
      seminar_video.update_column :media, media
    end
    migrated_count
  end
  
  def migrate_asset asset_id
    unless asset_id.blank?
      asset_results = @connection.query("SELECT * FROM assets WHERE id = #{asset_id}")
      asset_results.each_hash do |result|
        return result['path'].start_with?('/') ? result['path'][18..(result['path'].length)] : result['path'][17..(result['path'].length)]
      end
    end
  end
end
