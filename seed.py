# """ADD SOME CONTEXT HERE"""
# """VERIFY ALL IMPORTS ARE CORRECT"""

from sqlalchemy import func

from pprint import pprint

import json
import csv

from model import connect_to_db, db, Encounter, Location, User #(Gym?)

from server import app

#########################


def load_encounters(): #TESTED
    """Load encounter locations with Pokemon."""

    print 'Encounters'

    with open('/seed_data/encounter.json') as pokeloc_file:
            pokeloc_data = json.load(pokeloc_file)
            data_list = pokeloc_data.get('data') #now this is a list instead of a dict w/ 'data' as key

            encounter1 = data_list[0]
            encounter2 = data_list[1]
            encounter3 = data_list[2]
            encounter4 = data_list[3]
            encounter5 = data_list[4]
            encounter6 = data_list[5]
            encounter7 = data_list[6]
            encounter8 = data_list[7]
            encounter9 = data_list[8]
            encounter10 = data_list[9]

            encounter1, encounter2, encounter3, encounter4, encounter5, encounter6, encounter7, encounter8, encounter9, encounter10 = Encounter(
                latitude=latitude, pokemon_id=pokemonId, encounter_id=id, longitude=longitude)

            db.session.add(encounter1, encounter2, encounter3, encounter4, encounter5, encounter6, encounter7, encounter8, encounter9, encounter10)
            db.session.commit()


def load_yelp():

    #want to figure out how to iterate over files in the yelp_locations directory
    #longform code for now

    print 'Yelp Locations'

    with open('/seed_data/yelp_locations.json') as yelploc_file:
            yelploc_data = json.load(yelploc_file)
            data_list = yelploc_data.get('businesses')


    #####TODO#####
    #need to determine which restaurants are useful/viable, especially which are actual pokestops/gyms
    #might actually want to do a restaurant/bar search to get best bars on the route


#######TEST FOR ALL FILES##########

    with open('b_restaurant.json') as b_file:
            b_data=json.load(b_file)
            print b_data

    b_coords = b_data['coordinates']
    latitude = b_coords['latitude'] #plot value for map
    longitude = b_coords['longitude'] #plot value for map

    rating = b_data['rating'] #value for rating as integer
    name = b_data['name'] #value unicode string
    url = b_data['url'] #value unicode string

    all_cats = b_data['categories'] #list of dictionaries
    first_cat_dict = all_cats[0]
    cat_title = first_dict['title'] #value unicode string



###############################################


# if __name__ == "__main__":
#     connect_to_db(app)
#     db.create_all()

    # load_encounters()
    # load_users()
    # load_yelp()
    # set_val_user_id()
