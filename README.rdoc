= catan counter

this is a rails app that "keeps score" for you while playing settlers of catan.  this is *NOT* a playable game.  it just keeps score.

i personally like playing catan on a real board with real players.  it's annoying figuring out how many more activated knights we need (or don't need).  we tried keeping track of it on paper, but with the back and forth of barbarians attacking, cities being built/destroyed, knights activating/deactivating, it wasn't very effective.  it was a good excuse to build a rails app.

== expansions supported

the original intent was to keep score for the cities and knights expansion, but expansions are completely optional.

- cities and knights
- fishermen of catan

== installation

 git clone git://github.com/ordinaryzelig/catan-counter.git
 cd catan-counter/rails_app
 rake install

== boot

 ruby script/server -e production
 point browser to http://localhost:3000/

p.s. catan counter doesn't look too shabby on the iphone.  just find your server's ip address and point safari to

 ip.add.r.ess:3000
