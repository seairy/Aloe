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
      seminar_video: SeminarVideo.all.count,
      publication_category: PublicationCategory.all.count,
      publication_article: PublicationArticle.all.count,
      continent: Continent.all.count,
      country: Country.all.count,
      member: Member.all.count,
      payment: Payment.all.count,
      order: Order.all.count,
      line_item: LineItem.all.count }
  end
  
  def migrate
    @connection = Mysql.init
    @connection.options(Mysql::SET_CHARSET_NAME, 'utf8')
    @connection.real_connect("localhost", "root", "", "isclt")
    migrated_count = case params[:model_name]
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
    when 'publication_category' then migrate_publication_categories
    when 'publication_article' then migrate_publication_articles
    when 'continent' then migrate_continents
    when 'country' then migrate_countries
    when 'member' then migrate_members
    when 'payment' then migrate_payments
    when 'order' then migrate_orders
    when 'line_item' then migrate_line_items
    when 'all'
      count = migrate_articles
      count += migrate_resources
      count += migrate_topics
      count += migrate_theses
      count += migrate_books
      count += migrate_book_shelves
      count += migrate_links
      count += migrate_newsletters
      count += migrate_seminars
      count += migrate_seminar_thesis_categories
      count += migrate_seminar_theses
      count += migrate_seminar_articles
      count += migrate_seminar_photographs
      count += migrate_seminar_videos
      count += migrate_publication_categories
      count += migrate_publication_articles
      count += migrate_continents
      count += migrate_countries
      count += migrate_members
      count += migrate_payments
      count += migrate_orders
      count += migrate_line_items
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
  
  def migrate_publication_categories
    PublicationVolume.delete_all
    PublicationCategory.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM publication_catalogs")
    results.each_hash do |result|
      migrated_count += 1
      volume = PublicationVolume.where(publication_id: 1, name: result['issue'].force_encoding('utf-8')).first || PublicationVolume.create(publication_id: 1, name: result['issue'].force_encoding('utf-8'), featured: false)
      PublicationCategory.create({ id: result['id'], volume_id: volume.id, name: result['name'].force_encoding('utf-8'), created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_publication_articles
    PublicationArticle.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM publications")
    results.each_hash do |result|
      migrated_count += 1
      PublicationArticle.create({ id: result['id'], category_id: result['catalog_id'], title: result['title'].force_encoding('utf-8'), author: result['author'].force_encoding('utf-8'), organization: result['organization'].force_encoding('utf-8'), abstract: result['digest'].force_encoding('utf-8'), created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_continents
    Continent.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM continents")
    results.each_hash do |result|
      migrated_count += 1
      Continent.create({ id: result['id'], name: result['name'].force_encoding('utf-8'), created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_countries
    Country.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM countries")
    results.each_hash do |result|
      migrated_count += 1
      Country.create({ id: result['id'], continent_id: result['continent_id'], name: result['name'].force_encoding('utf-8'), created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_members
    Recipient.delete_all
    Contact.delete_all
    Member.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM members")
    results.each_hash do |result|
      if result['type'].force_encoding('utf-8') == 'IndividualMember' and result['approved'] == '1'
        migrated_count += 1
        foreign_name = result['foreign_name'].blank? ? '' : result['foreign_name'].force_encoding('utf-8')
        province = result['province'].blank? ? '' : result['province'].force_encoding('utf-8')
        address = result['address'].blank? ? '' : result['address'].force_encoding('utf-8')
        resume = result['resume'].blank? ? '' : result['resume'].force_encoding('utf-8')
        organization_name = result['organization_name'].blank? ? '' : result['organization_name'].force_encoding('utf-8')
        dispatched_organization_name = result['dispatched_organization_name'].blank? ? '' : result['dispatched_organization_name'].force_encoding('utf-8')
        president_of_ci = result['is_president_of_ci'].nil? ? false : result['is_president_of_ci']
        comment = result['comment'].blank? ? '' : result['comment'].force_encoding('utf-8')
        member = Member.create({ id: result['id'], type: 'IndividualMember', account: result['account'].force_encoding('utf-8'), hashed_password: result['hashed_password'].force_encoding('utf-8'), chinese_name: result['chinese_name'].force_encoding('utf-8'), foreign_name: foreign_name, country_id: result['country_id'], province: province, address: address, description: resume, degree: result['academic_degree'], organization_name: organization_name, dispatched_organization_name: dispatched_organization_name, president_of_ci: president_of_ci, public: true, remark: comment, balance: result['balance'], approved: result['approved'], permanent: result['permanent'], joined_at: result['joined_at'], expired_at: result['expired_at'], current_signined_at: result['last_signined_at'], last_signined_at: result['last_signined_at'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
        title = result['title'].blank? ? '' : result['title'].force_encoding('utf-8')
        phone = result['phone'].blank? ? '' : result['phone'].force_encoding('utf-8')
        mobile = result['mobile'].blank? ? '' : result['mobile'].force_encoding('utf-8')
        fax = result['fax'].blank? ? '' : result['fax'].force_encoding('utf-8')
        contact = member.contacts.create({ gender: result['gender'], title: title, phone: phone, mobile: mobile, fax: fax }, without_protection: true)
        member.recipients.create( name: result['email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['email'] != nil and result['email'] != ''
        member.recipients.create( name: result['spare_email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['spare_email'] != nil and result['spare_email'] != ''
      elsif result['type'].force_encoding('utf-8') == 'OrganizationMember' and result['approved'] == '1'
        migrated_count += 1
        foreign_name = result['foreign_name'].blank? ? '' : result['foreign_name'].force_encoding('utf-8')
        province = result['province'].blank? ? '' : result['province'].force_encoding('utf-8')
        address = result['address'].blank? ? '' : result['address'].force_encoding('utf-8')
        introduction = result['introduction'].blank? ? '' : result['introduction'].force_encoding('utf-8')
        profit = result['organization_nature'] == '1' ? true : false
        website = result['website'].blank? ? '' : result['website'].force_encoding('utf-8')
        comment = result['comment'].blank? ? '' : result['comment'].force_encoding('utf-8')
        member = Member.create({ id: result['id'], type: 'OrganizationMember', account: result['account'].force_encoding('utf-8'), hashed_password: result['hashed_password'].force_encoding('utf-8'), chinese_name: result['chinese_name'].force_encoding('utf-8'), foreign_name: foreign_name, country_id: result['country_id'], province: province, address: address, description: introduction, organization_type: result['organization_type'], profit: profit, website: website, public: true, remark: comment, balance: result['balance'], approved: result['approved'], permanent: result['permanent'], joined_at: result['joined_at'], expired_at: result['expired_at'], current_signined_at: result['last_signined_at'], last_signined_at: result['last_signined_at'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
        member.recipients.create( name: result['email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['email'] != nil and result['email'] != ''
        member.recipients.create( name: result['spare_email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['spare_email'] != nil and result['spare_email'] != ''
        contact = nil
        if result['responsible_person_name'] != nil and result['responsible_person_name'] != ''
          title = result['responsible_person_title'].blank? ? '' : result['responsible_person_title'].force_encoding('utf-8')
          phone = result['responsible_person_phone'].blank? ? '' : result['responsible_person_phone'].force_encoding('utf-8')
          mobile = result['responsible_person_mobile'].blank? ? '' : result['responsible_person_mobile'].force_encoding('utf-8')
          fax = result['responsible_person_fax'].blank? ? '' : result['responsible_person_fax'].force_encoding('utf-8')
          contact = member.contacts.create({ name: result['responsible_person_name'].force_encoding('utf-8'), title: title, phone: phone, mobile: mobile, fax: fax }, without_protection: true)
          member.recipients.create( name: result['responsible_person_email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['responsible_person_email'] != nil and result['responsible_person_email'] != ''
          member.recipients.create( name: result['responsible_person_spare_email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['responsible_person_spare_email'] != nil and result['responsible_person_spare_email'] != ''
        end
        if result['contact_person_name'] != nil and result['contact_person_name'] != ''
          title = result['contact_person_title'].blank? ? '' : result['contact_person_title'].force_encoding('utf-8')
          phone = result['contact_person_phone'].blank? ? '' : result['contact_person_phone'].force_encoding('utf-8')
          mobile = result['contact_person_mobile'].blank? ? '' : result['contact_person_mobile'].force_encoding('utf-8')
          fax = result['contact_person_fax'].blank? ? '' : result['contact_person_fax'].force_encoding('utf-8')
          contact = member.contacts.create({ name: result['contact_person_name'].force_encoding('utf-8'), title: title, phone: phone, mobile: mobile, fax: fax }, without_protection: true)
          member.recipients.create( name: result['contact_person_email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['contact_person_email'] != nil and result['contact_person_email'] != ''
          member.recipients.create( name: result['contact_person_spare_email'].force_encoding('utf-8'), available: true, subscribed: true ) if result['contact_person_spare_email'] != nil and result['contact_person_spare_email'] != ''
        end
      end
    end
    migrated_count
  end
  
  def migrate_payments
    Payment.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM payments")
    results.each_hash do |result|
      migrated_count += 1
      revenue = result['private'].to_i == 0 ? true : false
      remark = result['remarks'].blank? ? '' : result['remarks'].force_encoding('utf-8')
      Payment.create({ id: result['id'], member_id: result['member_id'], revenue: revenue, amount: result['amount'], paid_at: result['paid_at'], before_expired_at: result['expired_at'], extended_to: result['extended_at'], remark: remark, created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_orders
    Order.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM orders")
    results.each_hash do |result|
      migrated_count += 1
      name = result['chinese_name'] || result['foreign_name']
      address = result['chinese_address'] || result['foreign_address']
      Order.create({ id: result['id'], member_id: result['member_id'], name: name.force_encoding('utf-8'), address: address.force_encoding('utf-8'), postal_code: result['postal_code'].force_encoding('utf-8'), phone: result['phone'].force_encoding('utf-8'), mobile: result['mobile'].force_encoding('utf-8'), total_price: result['total_price'], status: result['status'], remark: result['remarks'].force_encoding('utf-8'), created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
    end
    migrated_count
  end
  
  def migrate_line_items
    LineItem.delete_all
    migrated_count = 0
    results = @connection.query("SELECT * FROM line_items")
    results.each_hash do |result|
      migrated_count += 1
      LineItem.create({ id: result['id'], order_id: result['order_id'], book_id: result['book_id'], price: result['price'], amount: result['amount'], created_at: result['created_at'], updated_at: result['updated_at'] }, without_protection: true)
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
