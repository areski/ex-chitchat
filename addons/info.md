
# Add breaking point in Phoenix

require IEx; IEx.pry

# DROP / Reset Database

mix ecto reset

same as:

mix do ecto.drop, ecto.create, ecto.migrate

# Many to Many relationship

https://coletiv.com/blog/many-to-many-relationships-with-ecto/

video: https://www.youtube.com/watch?v=Cl2U_8XtUBM

