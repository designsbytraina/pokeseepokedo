"""PokeSee, PokeDo"""

from jinja2 import StrictUndefined

from flask import Flask, render_template, request, flash, redirect, session, jsonify
from flask_debugtoolbar import DebugToolbarExtension

from model import connect_to_db, db, Encounter, Location, User, Gym, PokeType, PokeBase, TypeBase


app = Flask(__name__)
app.secret_key = '%g%y1\xf5\xa9\x91R\xc9\x88\x97\xdf$\xab\x86\xe9\x84\xb8<m:\xcb\xbf\xb0\x83\x93'

app.jinja_env.undefined = StrictUndefined


@app.route('/')
def index():
    """Render homepage."""

    return render_template('index.html')


@app.route('/poke-map.json', methods=['GET'])
def results():
    """Show map and directions based on user input.

    This function will also jsonify data to pass pokemon and locations
    to front end."""

    # get form variables (not using them in this demo)
    start_point = request.args.get('start-point')
    end_point = request.args.get('end-point')
    departure = request.args.get('departure')

    ##########

    # query all encounters in db
    encounters = Encounter.query.all() #yields a list of objects
    pokemon = PokeBase.query.all() #get all pokemon
    poke_types = PokeType.query.all() #get all poketypes for cross-ref
    types = TypeBase.query.all() #get all types

    # loop through encounters and add items to encounter_dict

    encounter_dict = {}
    for encounter in encounters:
        poke_id = encounter.pokemon_id
        enc_poke = pokemon[poke_id - 1] #index pokemon for encountered pokemon

        # NEED HELP HERE ITERATING THROUGH LIST INDEXING STRING
        # USE ENUMERATE OR RANGE SOMEHOW?
        # for i in poke_types:
        #     type_id = poke_types[i].type_id
        #     poke_type = types[type_id - 1].identifier

        type_id = poke_types[poke_id - 1].type_id
        poke_type = types[type_id - 1].identifier

        encounter_dict[encounter.encounter_id] = {"pokemon_id":poke_id,
                                                    "name":enc_poke.identifier,
                                                    "latitude":encounter.latitude,
                                                    "longitude":encounter.longitude,
                                                    "height":enc_poke.height,
                                                    "weight":enc_poke.weight,
                                                    "type":poke_type}

    ##########

    # query all locations in db
    locations = Location.query.all() #yields a list of objects

    # loop through locations and add items to location_dict
    location_dict = {}
    for location in locations:
        location_dict[location.location_id] = {"name":location.name,
                                                "latitude":location.latitude,
                                                "longitude":location.longitude,
                                                "rating":location.rating,
                                                "url":location.url,
                                                "category":location.category}

    ##########

    # query all gyms in db
    gyms = Gym.query.all() #yields a list of objects

    # loop through gyms and add items to gym_dict
    gym_dict = {}
    for gym in gyms:
        gym_dict[gym.gym_id] = {"name":gym.name,
                                "latitude":gym.latitude,
                                "longitude":gym.longitude}

    # combine dictionaries into dictionary of dictionaries
    dictionary = {"encounters": encounter_dict, "locations": location_dict, "gyms": gym_dict}

    # return jsonified dictionary that will be accessible in JS
    return jsonify(dictionary)


# TODO - SECOND SPRINT #########################################################

# possible way to implement
# @app.route('/#anchor-point')

###################

@app.route('/login', methods=['GET'])
def login_form():
    """Show login form."""

    return render_template("login.html")


@app.route('/login', methods=['POST'])
def login():
    """Processes login from login.html."""

    # get form variables
    username = request.form.get('username')
    password = request.form.get('password')

    # query db for user matching the username entered
    user = User.query.filter_by(username=username).first()

    # if the user's credentials are incorrect
    if not user:
        flash('We are sorry, your username/password do not match our records. Please try again, or register.')
        return redirect('/login')

    session['user_id'] = user.user_id

    flash('Welcome back, %s!' % username) 
    return redirect('/')


@app.route('/logout')
def logout():
    """Log out user."""

    # remove the user_id from the session
    del session['user_id']
    flash('You have been logged out.')
    return redirect('/')


###########################

@app.route('/register', methods=['GET'])
def register_form():
    """Show form for user signup."""

    return render_template("registration_form.html")


@app.route('/register', methods=['POST'])
def register_process():
    """Process registration."""

    username = request.form['username']
    email = request.form['email']
    password = request.form['new-password']
    first_name = request.form['first-name']
    last_name = request.form['last-name']

    new_user = User(username=username, email=email, password=password, first_name=first_name, last_name=last_name)

    db.session.add(new_user)
    db.session.commit()

    flash("Welcome, %s. Happy catching!" % username)
    return redirect("/")
    #TODO - add a homepage for users that shows their information, maybe timestamp for when registered??

    
############################################

if __name__ == "__main__":
    #must be true for debug toolbar
    app.debug = True

    connect_to_db(app)

    #use the debug toolbar
    # DebugToolbarExtension(app)

    # doesn't work on localhost - REMOVE
    # app.run()

    #run application
    app.run(debug=True, host='0.0.0.0', port=5000)
