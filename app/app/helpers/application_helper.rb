module ApplicationHelper

  def options_for_enum(object, enum)
    object.class.name.classify.safe_constantize.send(enum.to_s.pluralize).map do
    |key, value|
      [Utility.translate_enum_name(object.class.name, enum.to_s.pluralize, key), key]
    end
  end

  def options_for_select_estados(object)
    estados = BrasilApi.get_estados
    estados = estados.map { |e| [e['nome'], e['sigla']] }
    options_for_select(estados, object&.uf)
  end

  def options_for_select_municipios(object)
    return options_for_select([], nil) unless object.uf.present?
    municipios = BrasilApi.get_municipios(object&.uf)
    municipios = municipios.map { |e| [e['nome'].to_s.capitalize, e['nome'].to_s.capitalize] }
    options_for_select(municipios, object&.cidade)
  end

  def new_btn(klass, path, opt = { remote: false })
    link_to(Utility.translate_actions(klass, :new), path, class: 'btn-sm btn-primary', remote: opt[:remote])
  end

  def edit_btn(klass, path, opt = { remote: false })
    link_to(Utility.translate_actions(klass, :edit), path, class: 'btn-sm btn-warning', remote: opt[:remote])
  end

  def show_btn(klass, path, opt = { remote: false })
    link_to(
      Utility.translate_actions(klass, :show), path, class: 'btn-sm btn-success', remote: opt[:remote])
  end

  def open_lg_modal(content, opt = {})
    render 'components/modals/lg/open',
           content: content, locals_variables: opt[:locals_variables],
           modal_options: opt[:modal_options]
  end

  def close_lg_modal(opt = {})
    render 'components/modals/lg/close', obj: opt[:obj]
  end
end
