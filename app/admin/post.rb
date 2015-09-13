ActiveAdmin.register Post do
  permit_params :title, :content, :tag_list

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :tag_list
    column :created_at
    actions
  end

  filter :title
  filter :created_at

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
      f.input :tag_list,
        label: "Tags",
        input_html: {
          data: {
            placeholder: "Enter tags",
            saved: f.object.tags.map{|t| {id: t.name, name: t.name}}.to_json,
            url: autocomplete_tags_path },
          class: 'tagselect'
        }
    end
    f.actions
  end

  controller do
    def autocomplete_tags
      @tags = ActsAsTaggableOn::Tag.
        where("name LIKE ?", "#{params[:q]}%").
        order(:name)
      respond_to do |format|
        format.json { render json: @tags , :only => [:id, :name] }
      end
    end
  end

end
