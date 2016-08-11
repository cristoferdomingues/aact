class ResultGroup < StudyRelationship

  has_many :baseline_measures
  has_many :reported_events
  has_many :outcomes
  has_many :outcome_measures
  has_many :outcome_analyses


  def self.create_group_set(opts)
    group_xmls=opts[:xml].xpath("group_list").xpath('group')
    groups=[]
    xml=group_xmls.pop
    while xml
      if !xml.blank?
        opts[:xml]=xml
        groups << create_group_from(opts)
      end
      xml=group_xmls.pop
    end
		import(groups)
    groups
  end

  def self.create_group_from(opts)
    xml=opts[:xml]
    g=new({
      :nct_id           => opts[:nct_id],
      :ctgov_group_code => xml.attribute('group_id'),
      :result_type      => opts[:result_type],
      :title            => xml.xpath('title').text,
      :description      => xml.xpath('description').text,
    })
    g
  end

end
