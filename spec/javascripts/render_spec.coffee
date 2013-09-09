#= require support/sinon-1.7.3
#= require joker
describe "Joker.Render", ->
  render = null
  container = null

  beforeEach ->
    Joker.debug = true
    render = Joker.Render.getInstance()
    container = $ "<div />", "data-yield": true
    $("body").append container

  afterEach ->
    Joker.debug = false
    $("body").empty()

  it "must be an instance of Core", ->
    expect( Joker.Render.__super__.name ).to.equal "Core"

  it "should generate just a single instance of Render through the static method get_instance", ->
    expect( Joker.Render.getInstance() ).to.equal Joker.Render.getInstance()

  it "should append content1.html to data-yield", (done)->
    a = $ "<a />", text: "link1", "data-render":true, href: "/assets/support/content1.html", id: "myLink1"
    a.appendTo container
    render.linkClick({currentTarget: a[0]})
    setTimeout( ->
      expect( container.html() ).to.equal "<h1>Title 1</h1>"
      done()
    , 100 )

  it "should append content2.html to data-yield", (done)->
    a = $ "<a />", text: "link2", "data-render":true, href: "/assets/support/content2.html", id: "myLink2"
    a.appendTo container
    render.linkClick({currentTarget: a[0]})
    setTimeout( ->
      expect( container.html() ).to.equal "<h2>Title 2</h2>"
      done()
    , 100 )


