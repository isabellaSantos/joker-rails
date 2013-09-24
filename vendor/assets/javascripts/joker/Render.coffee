###
@summary     Joker
@description Framework of RIAs applications
@version     1.0.0
@file        Render.js
@author      Welington Sampaio (http://welington.zaez.net/)
@contact     http://jokerjs.zaez.net/contato

@copyright Copyright 2013 Zaez Solucoes em Tecnologia, all rights reserved.

This source file is free software, under the license MIT, available at:
http://jokerjs.zaez.net/license

This source file is distributed in the hope that it will be useful, but
WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
or FITNESS FOR A PARTICULAR PURPOSE. See the license files for details.

For details please refer to: http://jokerjs.zaez.net
###

###

###
class Joker.Render extends Joker.Core

  @debugPrefix: "Joker_Render"
  @className  : "Joker_Render"

  defaultMethod  : undefined

  ###
  Constructor method
  ###
  constructor: ->
    super
    @debug "Inicializando o Render"
    @setDefaults()
    @setEvents()

  ###
  Event triggered when a link to "render" is triggered
  @param {Event}
  @returns {Boolean} false
  ###
  linkClick: (e)->
    @debug "Evento de clique disparados para o elemento: ", e.currentTarget
    el = e.currentTarget
    target = if Object.isString(el.dataset.render) and el.dataset.render != "true"
      @libSupport("[data-yield-for=#{el.dataset.render}]")
    else
      @getRenderContainer()
    type   = if el.dataset.method? then el.dataset.method else @defaultMethod
    @load
      url   : el.getAttribute('href')
      method: type
      target: target.selector
    false

  ###
  Metodo que faz o laod do conteudo html
  @param {Object} obj
  @param {Boolean} add_push Informe se é para a
  ###
  load: (obj, add_push = true)->
    new Joker.Ajax
      url   : obj.url
      method: obj.method
      callbacks:
        success: (data, textStatus, jqXHR)=>
          history.pushState obj, "asd", obj.url if add_push
          $(obj.target).empty().html(data)

  ###
  Retorna o container default
  ###
  getRenderContainer: ->
    @libSupport "[data-yield]"

  ###
  Sets the values ​​of the standard rendering engine
  ###
  setDefaults: ->
    @debug "Definindo as configuracoes padroes"
    @defaultMethod   = "GET"

  ###
  Sets all events from the elements
  ###
  setEvents: ->
    @unsetEvents()
    @debug "Setando os eventos"
    @libSupport(document).on('click', '[data-render]', @libSupport.proxy(@linkClick,@))
    window.onpopstate = (config)=> @load config.state, false

  ###
  Removes all events from the elements with
  namespace .render
  ###
  unsetEvents: ->
    @debug "Removendo os eventos"
    @libSupport(document).off '.render'

  ###
  @type [Joker.Render]
  ###
  @instance  : undefined

  ###
  Retorna a variavel unica para a instacia do objeto
  @returns [Joker.Render]
  ###
  @getInstance: ->
    Joker.Render.instance =  new Joker.Render() unless Joker.Render.instance?
    Joker.Render.instance